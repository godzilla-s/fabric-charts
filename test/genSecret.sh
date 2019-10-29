#!/bin/bash 

basePath="./crypto-config"
channelFile="./channel-config/mychannel.tx"
ordererTlsCa=$(ls ${basePath}/ordererOrganizations/orderer.svc.cluster.local/tlsca/*.pem)
genesisBlock="./channel-config/genesis.block"
function createSecret() {
    namespace=$1
    org=$2
    adminPath=$basePath/peerOrganizations/${org}.svc.cluster.local/users/Admin@${org}.svc.cluster.local/msp
    AdminMSP_Cert=$(ls ${adminPath}/admincerts/*.pem)
    AdminMSP_Key=$(ls ${adminPath}/keystore/*_sk)
    AdminMSP_Ca=$(ls ${adminPath}/cacerts/*.pem)
    AdminMSP_TlsCa=$(ls ${adminPath}/tlscacerts/*.pem)
    # ====== org admin msp 
    kubectl create secret generic -n $namespace hlf-${org}-admin-cert --from-file=cert.pem=$AdminMSP_Cert
    kubectl create secret generic -n $namespace hlf-${org}-admin-key --from-file=key.pem=$AdminMSP_Key
    kubectl create secret generic -n $namespace hlf-${org}-admin-ca --from-file=cacert.pem=$AdminMSP_Ca
    kubectl create secret generic -n $namespace hlf-${org}-admin-tlsca --from-file=$AdminMSP_TlsCa

    # ====== org admin tls 
    adminPath=$basePath/peerOrganizations/${org}.svc.cluster.local/users/Admin@${org}.svc.cluster.local/tls 
    AdminTLS_Cert=$(ls ${adminPath}/client.crt)
    AdminTLS_Key=$(ls ${adminPath}/client.key)
    AdminTLS_Ca=$(ls ${adminPath}/ca.crt)
    kubectl create secret tls hlf-${org}-admin-tls-pair -n $namespace --key $AdminTLS_Key --cert $AdminTLS_Cert
    kubectl create secret generic hlf-${org}-admin-tls-crt -n $namespace --from-file=$AdminTLS_Ca

    peerBase=$basePath/peerOrganizations/${org}.svc.cluster.local/peers
    peers=$(ls ${peerBase})
    peerNum=${#peers[@]}
    for ((i=0; i<peerNum;i++)); do 
        peer=${peers[$i]}
        peerCert=$(ls ${peerBase}/${peer}/msp/signcerts/*.pem)
        peerKey=$(ls ${peerBase}/${peer}/msp/keystore/*_sk)
        peerCaCert=$(ls ${peerBase}/${peer}/msp/cacerts/*.pem)
        peerAdminCert=$(ls ${peerBase}/${peer}/msp/admincerts/*.pem)
        peerTlsCert=$(ls ${peerBase}/${peer}/msp/tlscacerts/*.pem)
        kubectl create secret generic -n $namespace hlf-${org}-peer${i}-idcert --from-file=cert.pem=$peerCert
        kubectl create secret generic -n $namespace hlf-${org}-peer${i}-idkey --from-file=key.pem=$peerKey 
        kubectl create secret generic -n $namespace hlf-${org}-peer${i}-root-ca --from-file=cacert.pem=$peerCaCert
        kubectl create secret generic -n $namespace hlf-${org}-peer${i}-admin-cert --from-file=cert.pem=$peerAdminCert
        kubectl create secret generic -n $namespace hlf-${org}-peer${i}-root-tlsca --from-file=tlscert.pem=$peerTlsCert

        peerTlsCert=$(ls ${peerBase}/${peer}/tls/server.crt)
        peerTlsKey=$(ls ${peerBase}/${peer}/tls/server.key)
        peerTlsCa=$(ls ${peerBase}/${peer}/tls/ca.crt)
        kubectl create secret tls hlf-${org}-peer${i}-tls-pair -n $namespace --key $peerTlsKey --cert $peerTlsCert 
        kubectl create secret generic hlf-${org}-peer${i}-tls-ca -n $namespace --from-file=ca.crt=$peerTlsCa
    done
    kubectl create secret generic hlf-channel-tx -n $namespace --from-file=$channelFile
    kubectl create secret generic hlf-orderer-tlsca -n $namespace --from-file=tlsca-orderer-cert.pem=$ordererTlsCa
}

function createOrdereSecret() {
    ordererOrg=$1
    namespace=$2
    ordererBase=$basePath/ordererOrganizations/orderer.svc.cluster.local/orderers 
    orderers=$(ls ${ordererBase})
    ordererNum=${#orderers[@]}
    for ((i=0; i<ordererNum; i++)); do 
        orderer=${orderers[$i]}
        ordererCert=$(ls ${ordererBase}/${orderer}/msp/signcerts/*.pem)
        ordererKey=$(ls ${ordererBase}/${orderer}/msp/keystore/*_sk)
        ordererCa=$(ls ${ordererBase}/${orderer}/msp/cacerts/*.pem)
        ordererAdminCert=$(ls ${ordererBase}/${orderer}/msp/admincerts/*.pem)
        ordererTlsRootCert=$(ls ${ordererBase}/${orderer}/msp/tlscacerts/*.pem)
        kubectl create secret generic hlf-${ordererOrg}-orderer${i}-idcert -n $namespace --from-file=cert.pem=$ordererCert
        kubectl create secret generic hlf-${ordererOrg}-orderer${i}-idkey -n $namespace --from-file=key.pem=$ordererKey
        kubectl create secret generic hlf-${ordererOrg}-orderer${i}-root-ca -n $namespace --from-file=cacert.pem=$ordererCa
        kubectl create secret generic hlf-${ordererOrg}-orderer${i}-root-tlsca -n $namespace --from-file=tlscacert.pem=$ordererTlsRootCert
        kubectl create secret generic hlf-${ordererOrg}-orderer${i}-admin-cert -n $namespace --from-file=cert.pem=$ordererAdminCert

        ordererTlsCert=$(ls ${ordererBase}/${orderer}/tls/server.crt)
        ordererTlsKey=$(ls ${ordererBase}/${orderer}/tls/server.key)
        ordererTlsCa=$(ls ${ordererBase}/${orderer}/tls/ca.crt)
        kubectl create secret tls hlf-${ordererOrg}-orderer${i}-tls-pair -n $namespace --key $ordererTlsKey --cert $ordererTlsCert
        kubectl create secret generic hlf-${ordererOrg}-orderer${i}-tls-ca -n $namespace --from-file=ca.crt=$ordererTlsCa
    done 
    kubectl create secret generic hlf-genesis-block -n $namespace --from-file=$genesisBlock
}
#kubectl create ns org1 
#kubectl create ns org2  

createSecret org1 org1
createSecret org2 org2

#kubectl create ns orderer
createOrdereSecret orderer orderer