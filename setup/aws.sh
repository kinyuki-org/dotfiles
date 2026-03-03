#!/bin/bash

if ! sudo -v 2>/dev/null; then
    echo "エラー: sudo権限が必要です。" >&2
    exit 1
fi

# AWS CLI v2
curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o /tmp/awscliv2.zip
unzip -q /tmp/awscliv2.zip -d /tmp
sudo /tmp/aws/install
rm -rf /tmp/awscliv2.zip /tmp/aws

aws --version
