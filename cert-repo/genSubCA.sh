#!/bin/bash

export CA_DIR=root-ca

# Certificate storage; new certificates will be placed here as they are issued.
export CA_CERT_DIR=$CA_DIR/certs

# Certificate database (index) and the files that hold the next certificate and CRL serial numbers
export CA_DB_DIR=$CA_DIR/db

# This directory will store the private keys, one for the CA and the other for the OCSP responder.
# It’s important that no other user has access to it.
# (In fact, if you’re going to be serious about the CA, the machine on which the root material is stored should have only a minimal number of user accounts.)
export CA_PRIVATE_DIR=$CA_DIR/private



function genSubCA {
    openssl req -new \
        -config sub-ca.conf \
        -out $CA_DIR/sub-ca.csr \
        -keyout $CA_PRIVATE_DIR/sub-ca.key


   openssl ca \
       -config root-ca.conf \
       -in $CA_DIR/sub-ca.csr \
       -out $CA_DIR/sub-ca.crt \
       -extensions sub_ca_ext
}

function genOpeSubCA {
   openssl ca \
       -config sub-ca.conf \
       -in $CA_DIR/server.csr \
       -out $CA_DIR/server.crt \
       -extensions server_ext

   openssl ca \
       -config sub-ca.conf \
       -in $CA_DIR/client.csr \
       -out $CA_DIR/client.crt \
       -extensions client_ext
}

# ################################## ### #
# ### Executors                      ### #
# ################################## ### #

rm -rf $CA_DIR

# Create destination Folder
createDestDir
genOpeSubCA