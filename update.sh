#!/bin/bash

function cpdir() {
cp -rf  `find $1/* -maxdepth 0 -type d` ./
rm -rf $1
}
git pull

#先删除除保留文件和目录以外的所有子目录及其文件、
find * | grep -v '\<iptv\|README.md\|update.sh\|_config.yml\>' | xargs rm -rf 


# update helloworld/passwall/passwall2
# git clone  https://github.com/fw876/helloworld.git && cpdir helloworld
git clone https://github.com/kenzok8/small.git && cpdir small
rm -rf luci-app-bypass && rm -rf mosdns && rm -rf luci-app-mosdns

# update istore
git clone https://github.com/linkease/istore.git && cp -rf istore/luci/* . ; rm -rf ./istore


# update ddnsto etc.
git clone https://github.com/linkease/nas-packages.git && cp -rf ./nas-packages/multimedia/* . ; cp -rf ./nas-packages/network/services/* . ; rm -rf ./nas-packages

git clone  https://github.com/linkease/nas-packages-luci.git && cp -rf ./nas-packages-luci/luci/* . ; rm -rf ./nas-packages-luci

# push to github
git add -A
git commit -am "update: $(date "+%Y-%m-%d %H:%M:%S")"
git push
