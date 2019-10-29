#!/bin/bash 

function delSecret() {
    ns=$1
    secrets=`kubectl get secret -n $ns | grep hlf-* | awk '{print $1}'`
    for s in $secrets; do
        kubectl delete secret $s -n $ns
    done
}

delSecret org1
delSecret org2
delSecret orderer 