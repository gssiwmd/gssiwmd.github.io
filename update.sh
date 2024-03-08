#!/bin/bash

function mvdir() {
mv -y `find $1/* -maxdepth 0 -type d` ./
rm -rf $1
}

# Update passwall
git clone  https://github.com/xiaorouji/openwrt-passwall && mvdir openwrt-passwall


# git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall-packages passwallpackages

# mv  -f  passwallpackages .

# update helloworld
# git clone  --depth 1 https://github.com/fw876/helloworld.git
# rm -rf ./helloworld/LICENSE
# rm -rf ./helloworld/README.md
# mv -f helloworld ./

# update istore
# git clone --depth 1 https://github.com/linkease/istore.git
# mv -f istore/luci ./
# rm -rf ./istore

# update ddnsto etc.
# git clone --depth 1 https://github.com/linkease/nas-packages nas
# mv -f nas/multimedia ./
# mv -f nas/network/services ./
# rm -rf nas
# git clone --depth 1 https://github.com/linkease/nas-packages-luci nasluci
# mv -f nasluci/luci ./
# rm -rf nasluci

# push to github
git add -A
git commit -am "update: $(date "+%Y-%m-%d %H:%M:%S")"
git push
