1.logstash-collector: 用于接收dockercontainer发送过来的日志信息，并将日志信息发送到队列中
2.logstash-indexer: 用于接收消息队列中未处理的日志信息，然后将该日志消息发送到elasticsearsh中进行存储及搜索分析

logstash_exporter

多个pipeline管理

logstash配置
1.logstatsh-configmap
2.logstatsh-deploy
3.logstatsh-svc
