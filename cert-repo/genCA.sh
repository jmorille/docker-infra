#!/bin/bash

export TARGET_DIR=root-ca

export CA_DIR=root-ca

# Certificate storage; new certificates will be placed here as they are issued.
export CA_CERT_DIR=$CA_DIR/certs

# Certificate database (index) and the files that hold the next certificate and CRL serial numbers
export CA_DB_DIR=$CA_DIR/db

# This directory will store the private keys, one for the CA and the other for the OCSP responder.
# It’s important that no other user has access to it.
# (In fact, if you’re going to be serious about the CA, the machine on which the root material is stored should have only a minimal number of user accounts.)
export CA_PRIVATE_DIR=$CA_DIR/private


function createDestDir {
  mkdir -p $TARGET_DIR

  mkdir -p $CA_CERT_DIR
  mkdir -p $CA_DB_DIR
  mkdir -p $CA_PRIVATE_DIR

  chmod 700 $CA_PRIVATE_DIR
  touch $CA_DB_DIR/index
  openssl rand -hex 16  > $CA_DB_DIR/serial
  echo 1001 > $CA_DB_DIR/crlnumber
}

function genCA {
    openssl req -new \
        -config root-ca.conf \
        -out $TARGET_DIR/root-ca.csr \
        -keyout $CA_PRIVATE_DIR/root-ca.key

   openssl ca -selfsign \
       -config root-ca.conf \
       -in $TARGET_DIR/root-ca.csr \
       -out $TARGET_DIR/root-ca.crt \
       -extensions ca_ext
}

function revokeCA {
   #  Because all certificates are stored in the certs/ directory, you only need to know the serial number.
   openssl ca \
       -config root-ca.conf \
       -revoke certs/1002.pem \
       -crl_reason keyCompromise
}

function genOpeCA {
   # To generate a CRL from the new CA, use the -gencrl switch of the ca command:
   openssl ca -gencrl \
       -config root-ca.conf \
       -out $TARGET_DIR/root-ca.crl

   # To issue a certificate, invoke the ca command with the desired parameters.
   openssl ca \
       -config root-ca.conf \
       -in $TARGET_DIR/sub-ca.csr \
       -out $TARGET_DIR/sub-ca.crt \
       -extensions sub_ca_ext
}


function genOcsp {
   # First, we create a key and CSR for the OCSP responder.
   # These two operations are done as for any non-CA certificate, which is why we don’t specify a configuration file
   openssl req -new \
       -newkey rsa:2048 \
       -subj "/C=FR/O=Example/CN=OCSP Root Responder" \
       -keyout $CA_PRIVATE_DIR/root-ocsp.key \
       -out $TARGET_DIR/root-ocsp.csr

   # Second, use the root CA to issue a certificate.
   openssl ca \
       -config root-ca.conf \
       -in $TARGET_DIR/root-ocsp.csr \
       -out $TARGET_DIR/root-ocsp.crt \
       -extensions ocsp_ext \
       -days 30
}

function startOcsp {
  # Now you have everything ready to start the OCSP responder.
  # For testing, you can do it from the same machine on which the root CA resides.
  # However, for production you must move the OCSP responder key and certificate elsewhere:
  openssl ocsp \
      -port 9080
      -index $CA_DB_DIR/index \
      -rsigner $TARGET_DIR/root-ocsp.crt \
      -rkey $CA_PRIVATE_DIR/root-ocsp.key \
      -CA $TARGET_DIR/root-ca.crt \
      -text
}

function testOcsp {
  # You can test the operation of the OCSP responder using the following command line:
  openssl ocsp \
      -issuer $TARGET_DIR/root-ca.crt \
      -CAfile $TARGET_DIR/root-ca.crt \
      -cert $TARGET_DIR/root-ocsp.crt \
      -url http://127.0.0.1:9080

}

# ################################## ### #
# ### Executors                      ### #
# ################################## ### #

rm -rf $CA_DIR

# Create destination Folder
createDestDir
genCA
genOpeCA
genOcsp