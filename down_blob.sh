#!/bin/bash
# create by wabcwang@126.com

if [ $# -lt 2  ]; then
        echo "$0  BASE_PATH YML_FILE_PATH"
        echo "$0  /home/XXX/XXX/cf-release /home/XXX/XXX/cf-release/releases/cf-225.yml"
        exit 0
fi

base_path=$1
yml_path=$2

echo "please check:  sudo apt-get install aria2"
bucket_name=$(grep "bucket_name" ${base_path}/config/final.yml  | awk '$1 {print $2}')
blobs=$(grep -rnI "object_id" ${base_path}/config/blobs.yml  | awk '$1{print $3}')

for blob in ${blobs[@]}
do
	#echo "nohup aria2c --split=10 -c -j 10  http://${bucket_name}.s3.amazonaws.com/${blob}  -o ../blobstore/${bucket_name}/${blob} &"
        nohup aria2c --split=10 -c -j 10 http://${bucket_name}.s3.amazonaws.com/${blob}  -o ../blobstore/${bucket_name}/${blob} &
done

#echo "" > temp.txt
blobs=$(grep -rnI "fingerprint" ${yml_path}  | awk '$1{print $3}')
for blob in ${blobs[@]}
do
	temp=$(grep -rnI "${blob}:" ${base_path}/.final_builds/ )
	if [ "$temp" != "" ]; then
		_file=$(echo $temp | awk -F: '$1{print $1}')
		_line=$(echo $temp | awk -F: '$1{print $2}')
		_line=$(expr $_line + 3)
		id=$(sed -n ${_line}p ${_file}| awk '$1{print $2}')
		#echo "nohup aria2c --split=10 -c -j 10  http://${bucket_name}.s3.amazonaws.com/${id} -o ../blobstore/${bucket_name}/${id} &" >> temp.txt
		nohup aria2c --split=10 -c -j 10  http://${bucket_name}.s3.amazonaws.com/${id} -o ../blobstore/${bucket_name}/${id} &
	else
		echo "$blob not found"
	fi
done
