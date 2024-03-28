#!/bin/bash

function cpdir() {
cp -rf  `find $1/* -maxdepth 0 -type d` ./
rm -rf $1
}

# update helloworld/passwall/passwall2
# git clone  https://github.com/fw876/helloworld.git && cpdir helloworld
git clone https://github.com/kenzok8/small.git && cpdir small

# update istore
git clone https://github.com/linkease/istore.git && cp -rf istore/luci/* . ; rm -rf ./istore


# update ddnsto etc.
git clone https://github.com/linkease/nas-packages.git && cp -rf ./nas-packages/multimedia/* . ; cp -rf ./nas-packages/network/services/* . ; rm -rf ./nas-packages

git clone  https://github.com/linkease/nas-packages-luci.git && cp -rf ./nas-packages-luci/luci/* . ; rm -rf ./nas-packages-luci

# push to github
git add -A
git commit -am "update: $(date "+%Y-%m-%d %H:%M:%S")"
git push
