#!/bin/bash

function mvdir() {
mv -n `find $1/* -maxdepth 0 -type d` ./
rm -rf $1
}

# Update passwall
git clone https://github.com/xiaorouji/openwrt-passwall passwall
mvdir passwall
git clone https://github.com/xiaorouji/openwrt-passwall-packages passwallpackages
mvdir passwallpackages

# update helloworld
git clone  https://github.com/fw876/helloworld.git
rm -rf ./helloworld/LICENSE
rm -rf ./helloworld/README.md
mvdir helloworld

# update istore
git clone https://github.com/linkease/istore.git
mvdir istore/luci
rm -rf ./istore

# update ddnsto etc.
git clone https://github.com/linkease/nas-packages nas
mvdir nas/multimedia
mvdir nas/network/services
rm -rf nas
git clone https://github.com/linkease/nas-packages-luci nasluci
mvdir nasluci/luci
rm -rf nasluci

# push to github
git add -A
git commit -am "update: $(date "+%Y-%m-%d %H:%M:%S")"
git push
