https://docs.openebs.io/docs/next/installation.html

https://docs.openebs.io/docs/next/prerequisites.html
1.宿主机安装open-iscsi
Debian/Ubuntu
apt-get install open-iscsi
systemctl enable open-iscsi
systemctl start open-iscsi
Centos
yum -y install iscsi-initiator-utils
systemctl enable iscsid
systemctl start iscsid

2.使用Operator安装运行OpenEBS
宿主机数据存储目录: /var/openebs
宿主机标签
# kubectl label node <node-name> "openebs.io/nodegroup"="storage-node"
#nodeSelector:
#  "openebs.io/nodegroup": "storage-node"

kubectl label nodes <node-name> node=openebs
nodeSelector:
  node: openebs

kubectl apply -f openebs-operator.yaml
#或者使用helm安装OpenEBS
#kubectl create namespace openebs
#helm install -n openebs --namespace openebs .

3.使用默认或自定义的storageclass
kubectl apply -f openebs-storageclasses.yaml

mountOptions:
  - vers=4.0
  - noresvport

4. 创建快照(试验)
kubectl create -f snapshot.yml
使用快照创建卷



生产环境推荐直接使用裸盘,使用cstor管理
openebs运行不依赖宿主机zfs，但是依旧建议宿主机安装zfs，便于维护和故障排除
存储默认开启checksum应对劣质硬件和云厂商掩盖的数据错误,压缩,3副本冗余
支持为每个卷设定冗余级别
支持为每个卷设定QOS,通过限制CPU/MEM实现

https://docs.openebs.io/docs/next/deploycstor.html
要求每个宿主机有N个相同容量的数据盘
kubectl get disks
编辑openebs-config.yaml 
加入disk列表
