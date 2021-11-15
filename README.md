# Hyperledger_Mir_BFT



# Hyperledger_External_Chaincode Lab
## Build the Network
```script
cd hlf_network

cp -R config /tmp/hyperledger/config/
cp -R sampleBuilder/ /tmp/hyperledger/sampleBuilder/
cp configtx.yaml /tmp/hyperledger/config/configtx.yaml

docker-compose up -d rca-org1 rca-org2 ca-tls
 ./allCAnReg.sh
 ./enrollAllOrgs.sh
docker-compose up -d peer1-org1 peer1-org2 orderer1-org1 orderer1-org2 couchdb0 couchdb1
```

### use cli to generate genesys block

```script
docker exec -it cli /bin/sh

source term-org1
configtxgen -profile ${CHANNEL_PROFILE} -outputBlock ${CHANNEL_NAME}.block -channelID ${CHANNEL_NAME}
```
source term-org1

osnadmin channel join --channelID ${CHANNEL_NAME} --config-block /tmp/hyperledger/config/${CHANNEL_NAME}.block -o $CORE_ORDERER_ADDRESS --ca-file $ORDERER_CA --client-cert $ADMIN_TLS_CERTFILE  --client-key $ADMIN_TLS_KEYFILE
peer channel join -b /tmp/hyperledger/config/${CHANNEL_NAME}.block

source term-org2
osnadmin channel join --channelID ${CHANNEL_NAME} --config-block /tmp/hyperledger/config/${CHANNEL_NAME}.block -o $CORE_ORDERER_ADDRESS --ca-file $ORDERER_CA --client-cert $ADMIN_TLS_CERTFILE  --client-key $ADMIN_TLS_KEYFILE
peer channel join -b /tmp/hyperledger/config/${CHANNEL_NAME}.block
```
Also for org3 and org4


## Install the Chaincode
```
cd ../external_sacc
tar cfz code.tar.gz connection.json
tar cfz sacc_external.tgz metadata.json code.tar.gz
```
```
source term-org1
peer lifecycle chaincode install ../external_sacc/sacc_external.tgz

source term-org2
peer lifecycle chaincode install ../external_sacc/sacc_external.tgz
```
```
source term-org1
peer lifecycle chaincode approveformyorg --tls --cafile $ORDERER_CA -o localhost:7050 --channelID channel1 --name sacc --version 1 --init-required --sequence 1 --waitForEvent --package-id xxxxx (refer from previous install command)

source term-org2
peer lifecycle chaincode approveformyorg --tls --cafile $ORDERER_CA -o localhost:8050 --channelID channel1 --name sacc --version 1 --init-required --sequence 1 --waitForEvent --package-id xxxxx
```
Also for org3 and org4

```
source term-org1
peer lifecycle chaincode commit --tls --cafile $ORDERER_CA -o localhost:7050 --peerAddresses $CORE_PEER_ADDRESS --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE --peerAddresses localhost:8051 --tlsRootCertFiles /tmp/hyperledger/org2/peer1/tls-msp/tlscacerts/tls-0-0-0-0-7052.pem --channelID channel1 --name sacc --version 1 --sequence 1 --init-required
```



## Build & deploy the Chaincode container
```
cd ../external_sacc
GO111MODULE=on go mod vendor
docker build -t hyperledger/sacc-ext .

cd ../hlf_network
docker-compose up -d sacc-ext
```
## Invoke and Query the external chaincode
```
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer1-org1 --tls true --cafile $ORDERER_CA --peerAddresses localhost:7051 --tlsRootCertFiles /tmp/hyperledger/org1/peer1/assets/tls-ca/tls-ca-cert.pem --peerAddresses localhost:8051 --tlsRootCertFiles /tmp/hyperledger/org2/peer1/assets/tls-ca/tls-ca-cert.pem --channelID channel1 --name sacc --isInit -c '{"Args":["name","doe"]}'

peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer1-org1 --tls true --cafile $ORDERER_CA --peerAddresses localhost:7051 --tlsRootCertFiles /tmp/hyperledger/org1/peer1/assets/tls-ca/tls-ca-cert.pem --peerAddresses localhost:8051 --tlsRootCertFiles /tmp/hyperledger/org2/peer1/assets/tls-ca/tls-ca-cert.pem --channelID channel1 --name sacc -c '{"Args":["set","name","JohnDoe"]}'

peer chaincode query -C channel1 -n sacc -c '{"Args":["get","name"]}'
```

:smiley:
