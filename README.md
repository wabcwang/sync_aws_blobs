# sync_aws_blobs
* 下载AWS上S3存储的资源到本地，用于bosh发布版本
* 资源默认下载在和sync_aws_blobs同级的目录blobstore下
* 默认使用aria2进行下载，执行脚本前请安装aria2
```
sudo apt-get install aria2
```

## 下载cf-release指定版本的blobstore
```
./cf_blob.sh /home/xxx/xxx/cf-release 225
```

## 下载其他的保存在AWS上的资源
```
./down_blob.sh /home/XXX/XXX/degio-release /home/XXX/XXX/diego-release/releases/diego-0.935.yml
```
