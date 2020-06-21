#!/bin/bash
LOG_FILE=ec2_script_log_file.txt
# time the script
start=`date +%s` > "$LOG_FILE"

# update applications installed on Linux OS
/bin/echo "################ YUM UPDATE ################" >> "$LOG_FILE"
yum update -y

## Install Python 3.8
/bin/echo "################ Python 3.8 - Prerequaities ################" >> "$LOG_FILE"
# Prerequaities
yum install gcc openssl-devel bzip2-devel libffi-devel -y
/bin/echo "################ Python 3.8 - Download ################" >> "$LOG_FILE"
#Download Python 3.8
cd /opt
wget https://www.python.org/ftp/python/3.8.2/Python-3.8.2.tgz
tar xzf Python-3.8.2.tgz
#Install Python 3.8
/bin/echo "################ Python 3.8 - Install ################" >> "$LOG_FILE"
cd Python-3.8.2
./configure --enable-optimizations
make altinstall
export PATH=$PATH:/usr/local/bin

# Your Custom Parameters
/bin/echo "################ Init Params ################" >> "$LOG_FILE"
PACKAGE_PATH=python/lib/python3.8/site-packages/
ZIP_FILE_NAME=<ZIP-FILE-NAME>.zip
BUCKET_NAME=<S3-BUCKET-NAME>
PIP_PACKAGE_NAME=<PIP-PACKAGE-NAME>

/bin/echo "################ Create Folder Structure ################" >> "$LOG_FILE"
cd /tmp
mkdir -p "$PACKAGE_PATH" >> "$LOG_FILE"
/bin/echo "################ PIP3 INSTALL ################" >> "$LOG_FILE"
pip3.8 install "$PIP_PACKAGE_NAME" -t "$PACKAGE_PATH" >> "$LOG_FILE"
/bin/echo "################ ZIP ################" >> "$LOG_FILE"
zip -r9 "$ZIP_FILE_NAME" python >> "$LOG_FILE"
/bin/echo "################ COPY ZIP TO S3 ################" >> "$LOG_FILE"
aws s3 cp "$ZIP_FILE_NAME" s3://"$BUCKET_NAME"/"$ZIP_FILE_NAME" >> "$LOG_FILE"

# time the script
end=`date +%s` >> "$LOG_FILE"
/bin/echo "total script time: $((end-start)) sec" >> "$LOG_FILE"
/bin/echo "################ END SCRIPT ################" >> "$LOG_FILE"
aws s3 cp "$LOG_FILE" s3://"$BUCKET_NAME"/"$LOG_FILE"