echo "Working on TLS-CA"

export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/tls-ca/crypto/tls-cert.pem
export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/tls-ca/admin

fabric-ca-client enroll -d -u https://tls-ca-admin:tls-ca-adminpw@0.0.0.0:7052
sleep 5

fabric-ca-client register -d --id.name peer1-org1 --id.secret peer1PW --id.type peer -u https://0.0.0.0:7052
fabric-ca-client register -d --id.name peer1-org2 --id.secret peer1PW --id.type peer -u https://0.0.0.0:7052
fabric-ca-client register -d --id.name peer1-org3 --id.secret peer1PW --id.type peer -u https://0.0.0.0:7052
fabric-ca-client register -d --id.name peer1-org4 --id.secret peer1PW --id.type peer -u https://0.0.0.0:7052

fabric-ca-client register -d --id.name orderer1-org1 --id.secret ordererPW --id.type orderer -u https://0.0.0.0:7052
fabric-ca-client register -d --id.name orderer1-org2 --id.secret ordererPW --id.type orderer -u https://0.0.0.0:7052
fabric-ca-client register -d --id.name orderer1-org3 --id.secret ordererPW --id.type orderer -u https://0.0.0.0:7052
fabric-ca-client register -d --id.name orderer1-org4 --id.secret ordererPW --id.type orderer -u https://0.0.0.0:7052

fabric-ca-client register -d --id.name admin-org1 --id.secret org1AdminPW --id.type admin -u https://0.0.0.0:7052
fabric-ca-client register -d --id.name admin-org2 --id.secret org2AdminPW --id.type admin -u https://0.0.0.0:7052
fabric-ca-client register -d --id.name admin-org3 --id.secret org3AdminPW --id.type admin -u https://0.0.0.0:7052
fabric-ca-client register -d --id.name admin-org4 --id.secret org4AdminPW --id.type admin -u https://0.0.0.0:7052

echo "Working on RCA-ORG1"

export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org1/ca/crypto/ca-cert.pem
export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/org1/ca/admin

fabric-ca-client enroll -d -u https://rca-org1-admin:rca-org1-adminpw@0.0.0.0:7054
sleep 5

fabric-ca-client register -d --id.name peer1-org1 --id.secret peer1PW --id.type peer -u https://0.0.0.0:7054
fabric-ca-client register -d --id.name orderer1-org1 --id.secret ordererpw --id.type orderer -u https://0.0.0.0:7054
fabric-ca-client register -d --id.name admin-org1 --id.secret org1AdminPW --id.type admin -u https://0.0.0.0:7054

echo "Working on RCA-ORG2"

export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org2/ca/crypto/ca-cert.pem
export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/org2/ca/admin

fabric-ca-client enroll -d -u https://rca-org2-admin:rca-org2-adminpw@0.0.0.0:7055
sleep 5

fabric-ca-client register -d --id.name peer1-org2 --id.secret peer1PW --id.type peer -u https://0.0.0.0:7055
fabric-ca-client register -d --id.name orderer1-org2 --id.secret ordererpw --id.type orderer -u https://0.0.0.0:7055
fabric-ca-client register -d --id.name admin-org2 --id.secret org2AdminPW --id.type admin -u https://0.0.0.0:7055

echo "Working on RCA-ORG3"

export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org3/ca/crypto/ca-cert.pem
export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/org3/ca/admin

fabric-ca-client enroll -d -u https://rca-org3-admin:rca-org3-adminpw@0.0.0.0:7056
sleep 5

fabric-ca-client register -d --id.name peer1-org3 --id.secret peer1PW --id.type peer -u https://0.0.0.0:7056
fabric-ca-client register -d --id.name orderer1-org3 --id.secret ordererpw --id.type orderer -u https://0.0.0.0:7056
fabric-ca-client register -d --id.name admin-org3 --id.secret org3AdminPW --id.type admin -u https://0.0.0.0:7056

echo "Working on RCA-ORG4"

export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org4/ca/crypto/ca-cert.pem
export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/org4/ca/admin

fabric-ca-client enroll -d -u https://rca-org4-admin:rca-org4-adminpw@0.0.0.0:7057
sleep 5

fabric-ca-client register -d --id.name peer1-org4 --id.secret peer1PW --id.type peer -u https://0.0.0.0:7057
fabric-ca-client register -d --id.name orderer1-org4 --id.secret ordererpw --id.type orderer -u https://0.0.0.0:7057
fabric-ca-client register -d --id.name admin-org4 --id.secret org4AdminPW --id.type admin -u https://0.0.0.0:7057
echo "All CA and registration done"