#!/bin/bash 

namespace=explorer
#kubectl create ns $namespace 

#kubectl create secret generic fabric-explore-config -n $namespace --from-file=first-network.json=./connection-profile/network-config.json

#kubectl create secret generic create-script -n $namespace --from-file=createdb.sh=./createdb.sh

basePath=./crypto-config/peerOrganizations/org1.svc.cluster.local/users/Admin@org1.svc.cluster.local/msp
admincert=$(ls $basePath/signcerts)
#echo $admincert
kubectl create secret generic org1-admin-cert -n $namespace --from-file=cert.pem=$basePath/signcerts/$admincert
adminkey=$(ls $basePath/keystore)
#echo $adminkey
kubectl create secret generic org1-admin-key -n $namespace --from-file=key.pem=$basePath/keystore/$adminkey
tlscacert=./crypto-config/peerOrganizations/org1.svc.cluster.local/tlsca/tlsca.org1.svc.cluster.local-cert.pem 
kubectl create secret generic org1-tlsca-cert -n $namespace --from-file=ca.crt=$tlscacert

basePath=./crypto-config/peerOrganizations/org2.svc.cluster.local/users/Admin@org2.svc.cluster.local/msp
admincert=$(ls $basePath/signcerts)
#echo $admincert
kubectl create secret generic org2-admin-cert -n $namespace --from-file=cert.pem=$basePath/signcerts/$admincert
adminkey=$(ls $basePath/keystore)
#echo $adminkey
kubectl create secret generic org2-admin-key -n $namespace --from-file=key.pem=$basePath/keystore/$adminkey
tlscacert=./crypto-config/peerOrganizations/org2.svc.cluster.local/tlsca/tlsca.org2.svc.cluster.local-cert.pem
kubectl create secret generic org2-tlsca-cert -n $namespace --from-file=ca.crt=$tlscacert
