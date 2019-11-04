# fabric-charts

## 使用说明
支持fabric 1.4.3 
### hf-peer
|参数|说明|备注|
|-|-|-|
|nameOverride|||
|fullnameOverride|整个服务的名称|建议指定|
|dockersocketPath||指定本地/var/run/docker.sock|
|service.portRequest|节点端口|默认7051|
|service.portEvent||默认7053|
|service.portCouchDB|couchdb指定端口|默认5984|
|peer.mspID|组织ID||
|peer.loglevel|节点peer的日志等级|INFO,DEBUG,WARN,ERROR|
|peer.secret.peerCert|节点的证书||
|peer.secret.peerKey|节点的私钥||
|peer.secret.peerRootCa|节点的根证书||
|peer.secret.peerRootTlsCa|节点的tls根证书||
|peer.secret.peerAdminCert|所属组织的管理员证书||
|peer.peerTls|节点的tls证书||
|peer.peerTlsCa|节点的tls根证书||
|peer.chaincode.loglevel|链码服务的日志等级||
|peer.chaincode.builder|链码编译时依赖镜像||
|peer.chaicnode.runtime|链码运行基础镜像||
|peer.chaincode.execTimeout|链码执行的超时时间|默认120s|
|peer.persistence.enabled|是否持久化挂卷|默认false|
|peer.persistence.storageClass|持久化PV定义的类名||
|peer.persistence.accessMode|持久卷的权限模式||
|peer.persistence.size|持久卷大小||
|client.enabled|是否启动client|默认false|
|client.channeltx|fabric网络的通道配置文件||
|client.secret.ordererTlsCa|orderer组织的tls证书||
|client.secret.userCert|用户证书||
|client.secret.userKey|使用私钥||
|client.secret.userRootCa|用户的根证书|组织的根证书|
|client.secret.userRootTlsCa|用户的tls根证书|组织的tls根证书|
|client.secret.userAdminCert|管理员证书|如果管理员本身，则与自己证书一致|
|client.persistence.enabled|是否使用持久卷|默认false|
|client.persistence.storageClass|持久卷名|enabled为true有效|
|client.persistence.accessMode|持久卷权限|enabled为true有效|
|client.persistence.size|持久卷大小|enabled为true有效|
|couchdb.enabled|是否使用couchdb|底层数据库，默认leveldb|
|couchdb.image|couchdb镜像||
|couchdb.tag|镜像标签|默认1.4.2|
|couchdb.username|couchdb的登录用户名||
|couchdb.password|couchdb的登陆密码||
|couchdb.persistence.enabled|couchdb是否使用持久卷|默认false|
|couchdb.persistence.storageClass|卷名称|同上|
|couchdb.persistence.accessMode|卷读写权限|同上|
|couchdb.persustence.size|卷大小|同上|


### hf-orderer
|参数|说明|备注|
|-|-|-|
|nameOverride|||
|fullnameOverride|整个服务的名称|建议指定|
|service.port|orderer服务的端口|默认7050|
|orderer.mspID|orderer组织ID||
|orderer.loglevel|orderer节点的日志等级||
|orderer.ordererType|排序算法|solo,kafka,etcdraft|
|orderer.secret.ordererCert|orderer节点的证书||
|orderer.secret.ordererKey|orderer节点的私钥||
|orderer.secret.ordererRootCa|orderer节点的根证书||
|orderer.secret.ordererRootTlsCa|orderer节点的tls根证书|用于通信|
|orderer.secret.ordererAdminCert|orderer节点的管理员证书||
|orderer.genesisBlock|创世区块的配置文件|存入k8s的secret中|
|orderer.persistence.enabled|是否使用持久卷|默认false|
|orderer.persistence.storageClass|卷名称|同上|
|orderer.persistence.accessMode|卷读写权限|同上|
|orderer.persustence.size|卷大小|同上|
|kafka.enabled|是否使用kafka|默认false,建议etcd|
|kafka.image|kakfa镜像||

### hf-ca 
|参数|说明|备注|
|-|-|-|
|nameOverride|||
|fullnameOverride|整个服务的名称|建议指定|
|ca.adminName|管理员名称|用于登录时使用|
|ca.adminPwd|密码||
|ca.secret.cert|ca服务启动时，是否使用证书|默认自动生成|
|ca.secret.key|ca服务器启动时，是否使用私钥|同上|
|ca.imdca.enabled|是否使用中间ca|默认false|
|ca.imdca.url|中间CA的url||
|ca.allowRemoveAffiliation|是否允许删除联盟权限|默认false|
|ca.allowRemoveIdentity|是否允许删除申请证书的用户|默认false|
|ca.persistence.enabled|是否使用持久卷|默认false|
|ca.persistence.storageClass|卷名称|同上|
|ca.persistence.accessMode|卷读写权限|同上|
|ca.persustence.size|卷大小|同上|
|storage.leveldb.persistence.enabled|是否挂卷|默认false|
|storage.leveldb.persistence.storageClass|卷名称|同上|
|storage.leveldb.persistence.accessMode|卷读写权限|同上|
|storage.leveldb.persustence.size|卷大小|同上|
|storage.mysql.enabled|是否使用mysql|默认false|
|storage.mysql.image|mysql镜像||
|storage.mysql.tag|mysql版本|建议5.7以上|
|storage.mysql.port|mysql端口|默认3306|
|storage.mysql.database|ca使用的数据库名称||
|storage.mysql.dbpwd|mysql密码||
|storage.mysql.persistence.enabled|mysql是否使用持久卷|默认false|
|storage.pg.enabled|是否使用pg||
|storage.pg.image|pg镜像||
|storage.pg.tag|版本|建议9.5以上|
|storage.pg.database|ca使用数据库名称，默认fabric_ca|
|storage.pg.passwd|数据库密码||
|storage.pg.persistence.enabled|是否使用持久卷||


### hf-explorer
|参数|说明|备注|
|-|-|-|
|nameOverride|||
|fullnameOverride|整个服务的名称|建议指定|
|service.port|explore服务的端口|默认8090|
|service.pgPort|使用的数据库端口|默认5432|
|secret.networkConfig|fabric网络配置||
|secret.createScript|数据库创建脚本||
|secret.orgSecret|相关组织的证书信息|配置文件中指定的|
|explorerdb.image|镜像||
|explorerdb.database|数据库名称|默认fabricexplorer|
|explorerdb.username|用户名|hhpoc|
|explorerdb.passwd|密码|默认password|


## 测试用例 
见 test 文件夹