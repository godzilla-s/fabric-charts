#!/bin/bash 

cryptogen generate --config=./crypto.yaml

mkdir channel-config
configtxgen --profile TwoOrgsOrdererGenesis -outputBlock channel-config/genesis.block
configtxgen --profile TwoOrgsChannel -outputCreateChannelTx channel-config/mychannel.tx --channelID mychannel