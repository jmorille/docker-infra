#!/bin/bash

# Doc : http://www.linux-france.org/prj/edu/archinet/systeme/ch24s03.html
# Apache https://httpd.apache.org/docs/2.4/fr/ssl/ssl_faq.html


# Gen Path
# #############
export TARGET_DIR=certs
export CA_DIR=$TARGET_DIR
#export PUB_DIR=pub
#export PRIV_DIR=priv
export PUB_DIR=.
export PRIV_DIR=.

# File
# #############
# ca.crt =  CAchain.pem
CERT_FILENAME=domain

# Certificate
# #############
NUMBITS=4096
CERT_CN="localhost"
CA_PASS="za@%-<e*SzTt<r:k3CKX"
CERT_PASS="NPRn[X(9M(@82<>d7@*z"


# KeyStore
# #############
export FILE_KEYSTORE_JKS="keystore-server.jks"
export FILE_KEYSTORE_PKCS12="server.p12"

export KEYSTORE_PK12_PASS=keystorePKCS12pass
export KEYSTORE_JKS_PASS=keystoreJKSPass



# Functions
# #############

function createDestDir {
    mkdir -p $TARGET_DIR/$PRIV_DIR
    mkdir -p $TARGET_DIR/$PUB_DIR
    mkdir -p $CA_DIR/$PRIV_DIR
    mkdir -p $CA_DIR/$PUB_DIR
}


function docCertificateSubject {
  echo "###  Create the Server Key and Certificate Signing Request"
  echo "### ########################################################"
  echo "### First parameter :  $CERT_PASS"
  echo "/C  =  Country	                 GB"
  echo "/ST =  State	                 London"
  echo "/L  =  Location	                 London"
  echo "/O  =  Organization	             Global Security"
  echo "/OU =  Organizational Unit       IT Department"
  echo "/CN =  Common Name	             example.com"
}


# ################################## ### #
# ### Certificate Authority          ### #
# ################################## ### #

function createCA {
  # Créez une clé privée RSA pour votre serveur (elle sera au format PEM et chiffrée en Triple-DES) :
  openssl genrsa -aes256 -passout pass:$CA_PASS -out $CA_DIR/$PRIV_DIR/ca.key $NUMBITS

  #  Vous pouvez afficher les détails de cette clé privée RSA à l'aide de la commande :
  # openssl rsa -noout -text -in $CA_DIR/$PRIV_DIR/ca.key

  # Créez un certificat auto-signé (structure X509) à l'aide de la clé RSA que vous venez de générer (la sortie sera au format PEM) :
  # openssl req -x509 -new -nodes -extensions usr_cert  -sha1   -days 7300 -passin pass:$CA_PASS  -key $CA_DIR/$PRIV_DIR/ca.key -out $CA_DIR/$PUB_DIR/ca.crt -subj $CA_SUBJ
  # openssl req -x509 -new -nodes -extensions v3_ca     -sha512 -days 7300 -passin pass:$CA_PASS  -key $CA_DIR/$PRIV_DIR/ca.key -out $CA_DIR/$PUB_DIR/ca.crt -subj $CA_SUBJ
    openssl req -x509 -new         -extensions v3_ca    -sha256 -days 7300 -passin pass:$CA_PASS  -key $CA_DIR/$PRIV_DIR/ca.key -out $CA_DIR/$PUB_DIR/ca.crt -subj $CA_SUBJ


  # Record password
  echo "$CA_PASS" > $CA_DIR/$PRIV_DIR/ca.key.password

  # Suppress password for CA Key
  # unpassswdCAKey

  printCA
}

function unpassswdCAKey {
  # Créer une version PEM non chiffrée (non recommandé) de cette clé privée RSA	avec :
  openssl rsa  -passin pass:$CA_PASS -in $CA_DIR/$PRIV_DIR/ca.key -out $CA_DIR/$PRIV_DIR/ca.key.unsecure
}


function printCA {
   # Vous pouvez afficher les détails de ce certificat avec :
   echo "# ### ############################################### ### #"
   echo "# ### CA Root Certificate                             ### #"
   echo "# ### ############################################### ### #"
   openssl x509 -noout -text -passin pass:$CA_PASS  -in $CA_DIR/$PUB_DIR/ca.crt
   echo "# ### ############################################### ### #"
}

# ################################## ### #
# ### AutoSign Certificate Domain    ### #
# ################################## ### #


function createAutoSignCertificateTls {
 # create Auto Sign certificat  SSL fot test  
 # openssl req -new -x509 -nodes -out  $TARGET_DIR/$PRIV_DIR/$CERT_FILENAME.crt -keyout  $TARGET_DIR/$PRIV_DIR/$CERT_FILENAME.key -subj $CERT_SUBJ
 openssl req -newkey rsa:$NUMBITS -nodes -sha256 -days 365 -x509 -keyout $TARGET_DIR/$PRIV_DIR/$CERT_FILENAME.key -out $TARGET_DIR/$PRIV_DIR/$CERT_FILENAME.crt -subj $CERT_SUBJ
}


function unpassswdCertificateTlsKey {
 # Supprimer le chiffrement de la clé privée RSA (tout en conservant une copie de sauvegarde du fichier original) :
 openssl rsa  -passin pass:$CERT_PASS  -in $TARGET_DIR/$PRIV_DIR/$CERT_FILENAME-secure.key -out $TARGET_DIR/$PUB_DIR/$CERT_FILENAME.key
}


# ############################# #
# ### Certificate Domain    ### #
# ############################# #

function createCertificateTls {
 echo "### Generate Certificate for Domain $CERT_CN"
 # Créez une clé privée RSA pour votre serveur Apache (elle sera au format PEM et chiffrée en Triple-DES):
 openssl genrsa -des3  -passout pass:$CERT_PASS -out $TARGET_DIR/$PRIV_DIR/$CERT_FILENAME-secure.key $NUMBITS

 # Enregistrez le fichier $TARGET_DIR/$PRIV_DIR/$CERT_FILENAME-secure.key et le mot de passe éventuellement défini en lieu sûr.
 #  echo "$CERT_PASS" > $$TARGET_DIR/$PRIV_DIR/$CERT_FILENAME-secure.key.password

 # Vous pouvez afficher les détails de cette clé privée RSA à l'aide de la commande :
 # openssl rsa -passin pass:$CERT_PASS -noout -text -in $TARGET_DIR/$PRIV_DIR/$CERT_FILENAME-secure.key
 
 # Créez une Demande de signature de Certificat (CSR) à l'aide de la clé privée précédemment générée (la sortie sera au format PEM):
 # openssl req -new -passin pass:$CERT_PASS -key $TARGET_DIR/$PRIV_DIR/$CERT_FILENAME-secure.key -out $TARGET_DIR/$PRIV_DIR/$CERT_FILENAME.csr -subj $CERT_SUBJ
 openssl req -new -sha512 -passin pass:$CERT_PASS -key $TARGET_DIR/$PRIV_DIR/$CERT_FILENAME-secure.key -out $TARGET_DIR/$PRIV_DIR/$CERT_FILENAME.csr -subj $CERT_SUBJ

 # Vous devez entrer le Nom de Domaine Pleinement Qualifié ("Fully Qualified Domain Name" ou FQDN) 
 # de votre serveur lorsqu'OpenSSL vous demande le "CommonName", 
 # c'est à dire que si vous générez une CSR pour un site web auquel on accèdera par l'URL https://www.foo.dom/, le FQDN sera "www.foo.dom". 
 
 # printCsr

}

function printCsr {
 # Vous pouvez afficher les détails de ce CSR avec :
 openssl req -passin pass:$CERT_PASS -noout -text -in $TARGET_DIR/$PRIV_DIR/$CERT_FILENAME.csr
}


function signCertificateTlsWithCa {
  # La commande qui signe la demande de certificat est la suivante : ==>  CRT = CSR + CA sign
  # openssl x509 -req -passin pass:$CA_PASS  -in $TARGET_DIR/$PRIV_DIR/$CERT_FILENAME.csr -out $TARGET_DIR/$PUB_DIR/$CERT_FILENAME.crt -CA $CA_DIR/$PUB_DIR/ca.crt -CAkey $CA_DIR/$PRIV_DIR/ca.key -CAcreateserial -CAserial $CA_DIR/$PRIV_DIR/ca.srl
  openssl x509 -req -days 365 -sha512 -passin pass:$CA_PASS  -in $TARGET_DIR/$PRIV_DIR/$CERT_FILENAME.csr -out $TARGET_DIR/$PUB_DIR/$CERT_FILENAME.crt -CA $CA_DIR/$PUB_DIR/ca.crt -CAkey $CA_DIR/$PRIV_DIR/ca.key -CAcreateserial

  # printCrt
}

function copyCA2CertificateTls {
  cp  $CA_DIR/$PUB_DIR/ca.crt  $TARGET_DIR/$PUB_DIR/ca.crt
  cp $CA_DIR/$PRIV_DIR/ca.key  $TARGET_DIR/$PUB_DIR/ca.key
}



function printCrt {
  # Une fois la CSR signée, vous pouvez afficher les détails du certificat comme suit :
  openssl x509 -noout -text -in $TARGET_DIR/$PUB_DIR/$CERT_FILENAME.crt
}



# ################################## ### #
# ### Merge Certificates             ### #
# ################################## ### #


function mergeAllCertificats {
 # -->   $TARGET_DIR/$PUB_DIR/$CERT_FILENAME-chain.pem
 # combines the cacerts file from the openssl distribution  $TARGET_DIR/$PUB_DIR/$CERT_FILENAME-chain.pem and the intermediate.crt file.
 cat $TARGET_DIR/$PRIV_DIR/$CERT_FILENAME-secure.key $TARGET_DIR/$PUB_DIR/$CERT_FILENAME.crt $CA_DIR/$PUB_DIR/ca.crt > $TARGET_DIR/$PUB_DIR/$CERT_FILENAME-chain.pem

 # After combining the ASCII data into one file, verify validity of certificate chain for sslserver usage:
 openssl verify -verbose -purpose sslserver -CAfile $CA_DIR/$PUB_DIR/ca.crt $TARGET_DIR/$PUB_DIR/$CERT_FILENAME-chain.pem

 # Combine the private key, certificate, and CA chain into a PFX:
 # http://esupport.trendmicro.com/solution/en-US/1106466.aspx
 # openssl pkcs12 -export -out $TARGET_DIR/$PUB_DIR/$CERT_FILENAME-chains.pfx -inkey $TARGET_DIR/$PRIV_DIR/$CERT_FILENAME-secure.key -inkey $CA_DIR/$PRIV_DIR/ca.key -in $TARGET_DIR/$PUB_DIR/$CERT_FILENAME-chains.crt -certfile $CA_DIR/$PUB_DIR/ca.crt

 # Convert crt to pem
 # openssl x509 -in allcacerts.crt -out allcacerts.pem -outform PEM
 # openssl x509 -inform DER -in allcacerts.crt -out allcacerts.pem -text
}

function verifyCertificateTlsForCA {
   openssl verify -verbose -purpose sslserver -CAfile $CA_DIR/$PUB_DIR/ca.crt $TARGET_DIR/$PUB_DIR/$CERT_FILENAME.crt
}


# ################################## ### #
# ### Keystore                       ### #
# ################################## ### #

function createNewKeystorePKCS12 {
 # -->  server.p12
   if [ -f "$FILE_KEYSTORE_PKCS12" ]
   then
	echo "$FILE_KEYSTORE_PKCS12 found."
        rm $FILE_KEYSTORE_PKCS12
   else
	echo "$FILE_KEYSTORE_PKCS12 not found."
   fi

   # Test for all Certificate File
   FILE_ALL_CERT= $TARGET_DIR/$PUB_DIR/$CERT_FILENAME-chain.pem
   if [ -f "$FILE_ALL_CERT" ]
   then
	echo "$FILE_ALL_CERT found." 
   else
	echo "$FILE_ALL_CERT not found."
        mergeAllCertificats
   fi

   # create PKCS12 format keystores.
   openssl pkcs12 -passin pass:$CERT_PASS -passout pass:$KEYSTORE_PK12_PASS  -export -in $TARGET_DIR/$PUB_DIR/$CERT_FILENAME.crt -inkey $TARGET_DIR/$PRIV_DIR/$CERT_FILENAME-secure.key -out $FILE_KEYSTORE_PKCS12 -name tomcat -CAfile  $TARGET_DIR/$PUB_DIR/$CERT_FILENAME-chain.pem -caname root -chain
 }

function createNewKeystoreJKS {
   # Keystore Vide
   if [ -f "$FILE_KEYSTORE_JKS" ]
   then
	echo "$FILE_KEYSTORE_JKS found."
        rm $FILE_KEYSTORE_JKS
   else
	echo "$FILE_KEYSTORE_JKS not found."
   fi

   #keytool -certreq -keyalg RSA -alias server -file $TARGET_DIR/$PRIV_DIR/$CERT_FILENAME.csr -keystore server-keystore.jks -storepass $CA_PASS01 -keypass $CA_PASS01
   # keytool -genkey -alias server -keyalg rsa -keysize 1024 -keystore server-keystore.jks -storetype JKS -storepass $CA_PASS01 -keypass $CA_PASS01 -dname "CN=integ2, OU=COM, O=$CA_PASS, L=PARIS, ST=PARIS, C=FR, emailAddress=test@$CA_PASS.fr" 

   keytool -genkey -alias tomcat -keyalg RSA  -keysize $NUMBITS -keypass $CERT_PASS -keystore $FILE_KEYSTORE_JKS -storetype JKS -storepass $KEYSTORE_JKS_PASS -dname "CN=integ2, OU=COM, O=Organisation, L=PARIS, ST=PARIS, C=FR, emailAddress=test@organisation.fr"
}

function importKeystoreJKSCertificates { 
 # Import the Chain Certificate into your keystore   
 # keytool -import -alias root -keystore $FILE_KEYSTORE_JKS -storepass $KEYSTORE_JKS_PASS -trustcacerts -noprompt -file   $TARGET_DIR/$PUB_DIR/$CERT_FILENAME-chain.pem

 # keytool -import -alias root -keystore $FILE_KEYSTORE_JKS -storepass $KEYSTORE_JKS_PASS -trustcacerts -noprompt -file  $CA_DIR/$PUB_DIR/ca.crt
 # keytool -import -alias tomcat -keystore $FILE_KEYSTORE_JKS -storepass $KEYSTORE_JKS_PASS -trustcacerts -noprompt -file  $TARGET_DIR/$PUB_DIR/$CERT_FILENAME.crt
 # keytool -alias dmzlan -import -keystore /DATA/API/certificates/api_keystore.jks -file /DATA/API/certificates/server-lanDmz.crt -storepass $KEYSTORE_JKS_PASS
 
 # List KeyStore
 printKeystoreJKSCertificates
}
 
function printKeystoreJKSCertificates { 
 # List KeyStore
 keytool -list -v -keystore $FILE_KEYSTORE_JKS -storepass $KEYSTORE_JKS_PASS
}


# ################################## ### #
# ### DHE Certificate                ### #
# ################################## ### #


function createDHECertificate {
  cd  ssl
  openssl dhparam -out $TARGET_DIR/$PUB_DIR/dhparam.pem $NUMBITS
}

# ################################## ### #
# ### Scheduler                      ### #
# ################################## ### #

function setup {

  # Script Start
  # chmod +x /build/*.sh


  # Create Ca Certificate ==> $CA_DIR/$PUB_DIR/ca.crt 
  createCA|| exit 1

  # Create Server Certificate ==>  $TARGET_DIR/$PRIV_DIR/$CERT_FILENAME.csr
  createCertificateTls || exit 1

  # Sign Server Certificate With CA  ==> $TARGET_DIR/$PUB_DIR/$CERT_FILENAME.crt
  signCertificateTlsWithCa || exit 1

  # Supprimer le chiffrement de la clé privée RSA  : ==> server-nopasswd.key
  unpassswdCertificateTlsKey || exit 1
  
  # Merge All Certificats ==>  $TARGET_DIR/$PUB_DIR/$CERT_FILENAME-chain.pem
  mergeAllCertificats || exit 1
  
  # KeyStore PKCS12 ==> $CERT_FILENAME.p12
  # createNewKeystorePKCS12 || exit 1
  
  # KeyStore JKS  ==>  keystore-server.jks 
  # createNewKeystoreJKS || exit 1
  # importKeystoreJKSCertificates || exit 1


  # Security tools
  #createDHECertificate || exit 1
}

function setupAutoSignCert {
    createAutoSignCertificateTls || exit 1
}

# ################################## ### #
# ### Usage info                      ### #
# ################################## ### #

# Usage info
usage() {
    cat << EOF
    Usage: ${0##*/} [-hv] [-d DOMAIN] [ACTION]...
    Do stuff with FILE and write the result to standard output. With no FILE
    or when FILE is -, read standard input.

    OPTIONS
       -h, --help                display this help and exit
       -d, --domain DOMAIN       Domain for Certificate
       -f, --file FILENAME       File Name for Certificate. (Default $CERT_FILENAME.(key|crt)
       -b, --numbits SIZE        Number of bits for the certificate (Default $NUMBITS bits)
       --caDir PATH              CA Path Folder
       --certDir PATH            Server Certificate Path Folder
       --caPass PASSWORD         CA Password.
       --serverPass PASSWORD     Server Certificate Password
       -v                        verbose mode. Can be used multiple times for increased
                                 verbosity.

    ACTION
      setup
      ca                Generate CA (Certificate Authority)
      autoSignCert      Generate auto sign Certificate for Test
      cert              Generate Server Certificate (for a specific domain)
      sign              Sign Server Certificate with CA
      certSign          Generate Server Certificate Sign with existing CA
      verifCertSign     Verify that a certificate was issued by a specific CA
      printCA
      printCsr
      printCrt
      keystoreJKS
      printJKS
      dhparam           Generate DHECertificate

EOF
}



# ################################## ### #
# ### Command  Line Options Parser   ### #
# ################################## ### #

i=$(($# + 1)) # index of the first non-existing argument
declare -A longoptspec
# Use associative array to declare how many arguments a long option
# expects. In this case we declare that loglevel expects/has one
# argument and range has two. Long options that aren't listed in this
# way will have zero arguments by default.
longoptspec=( [domain]=1 [numbits]=1 [caPass]=1 [serverPass]=1 [help]=0)
optspec=":hd:f:b:-:"
while getopts "$optspec" opt; do
while true; do
    case "${opt}" in
        -) #OPTARG is name-of-long-option or name-of-long-option=value
            if [[ ${OPTARG} =~ .*=.* ]] # with this --key=value format only one argument is possible
            then
                opt=${OPTARG/=*/}
                ((${#opt} <= 1)) && {
                    echo "Syntax error: Invalid long option '$opt'" >&2
                    exit 2
                }
                if (($((longoptspec[$opt])) != 1))
                then
                    echo "Syntax error: Option '$opt' does not support this syntax." >&2
                    exit 2
                fi
                OPTARG=${OPTARG#*=}
            else #with this --key value1 value2 format multiple arguments are possible
                opt="$OPTARG"
                ((${#opt} <= 1)) && {
                    echo "Syntax error: Invalid long option '$opt'" >&2
                    exit 2
                }
                OPTARG=(${@:OPTIND:$((longoptspec[$opt]))})
                ((OPTIND+=longoptspec[$opt]))
                echo $OPTIND
                ((OPTIND > i)) && {
                    echo "Syntax error: Not all required arguments for option '$opt' are given." >&2
                    exit 3
                }
            fi

            continue #now that opt/OPTARG are set we can process them as
            # if getopts would've given us long options
            ;;
        d|domain)
            export CERT_CN=$OPTARG
            ;;
        f|file)
            CERT_FILENAME=$OPTARG
            ;;
        b|numbits)
            NUMBITS=$OPTARG
            ;;
        caDir)
            CA_DIR=$OPTARG
            ;;
        certDir)
            TARGET_DIR=$OPTARG
            ;;
        caPass)
            echo "CA PAss option '$OPTARG'" >&2
            CA_PASS=$OPTARG
            ;;
        serverPass)
            echo "CERT PAss option '$OPTARG'" >&2
            CERT_PASS=$OPTARG
            ;;
        h|help)
            usage
            exit 0
            ;;
        ?)
            echo "Syntax error: Unknown short option '$OPTARG'" >&2
            exit 2
            ;;
        *)
            echo "Syntax error: Unknown long option '$opt'" >&2
            exit 2
            ;;
    esac
break; done
done


# ################################## ### #
# ### Certificate Subject            ### #
# ################################## ### #
CA_SUBJ="/C=FR/ST=France/L=Paris/O=Organisation/OU=DSI/CN=RootCA"
CERT_SUBJ="/C=FR/ST=France/L=Paris/O=Organisation/OU=IT/CN=$CERT_CN"


# ################################## ### #
# ### Display configuration          ### #
# ################################## ### #
echo ""
echo "# ########################################## #"
echo "# Domain=$CERT_CN"
echo "# Certificat Subject=$CERT_SUBJ"
echo "# CA password=$CA_PASS"
echo "# Certificat password=$CERT_PASS"
echo "# ########################################## #"
echo "# First non-option-argument (if exists): ${!OPTIND-}"
echo "# ########################################## #"
echo ""



# ################################## ### #
# ### Executors                      ### #
# ################################## ### #

# Create destination Folder
createDestDir

# Select Executor
case "${!OPTIND-}" in
  setup)
    setup $2 || exit 1
    ;;
  ca)
    createCA $2 || exit 1
    ;;
  printCA)
    printCA $2 || exit 1
    ;;
  autoSignCert)
    setupAutoSignCert || exit 1
    ;;
  cert)
    createCertificateTls $2 || exit 1
    ;;
  printCsr)
    printCsr $2 || exit 1
    ;;
  printCrt)
    printCrt $2 || exit 1
    ;;
  sign)
    signCertificateTlsWithCa $2 || exit 1
    ;;
  certSign)
    createCertificateTls $2 || exit 1
    signCertificateTlsWithCa $2 || exit 1
    ;;
  verifCertSign)
    verifyCertificateTlsForCA $2 || exit 1
    ;;
  keystoreJKS)
    createNewKeystoreJKS $2 || exit 1
    ;;
  printJKS)
    printKeystoreJKSCertificates $2 || exit 1
    ;;
  dhparam)
    createDHECertificate $2 || exit 1
    ;;
  *)
    #echo "Usage: $0 setup | autoSignCert | ca | cert | sign | certSign | printCA | printCsr | printCrt | keystoreJKS | printJKS | dhparam" >&2
    usage
    exit 1
    ;;
esac
exit 0

