#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.8.8/g' package/base-files/files/bin/config_generate

# Modify default theme
# sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate


#将clash内核、TUN内核、Meta内核编译进目录
mkdir -p files/etc/openclash/core
curl -L https://raw.githubusercontent.com/vernesong/OpenClash/core/master/dev/clash-linux-amd64.tar.gz | tar -xz -C /tmp
mv /tmp/clash files/etc/openclash/core/clash
chmod 0755 files/etc/openclash/core/clash
curl -L https://raw.githubusercontent.com/vernesong/OpenClash/core/master/premium/clash-linux-amd64-2023.08.17-13-gdcc8d87.gz | gunzip -c > /tmp/clash_tun
mv /tmp/clash_tun files/etc/openclash/core/clash_tun
chmod 0755 files/etc/openclash/core/clash_tun
curl -L https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-amd64.tar.gz | tar -xz -C /tmp
mv /tmp/clash files/etc/openclash/core/clash_meta
chmod 0755 files/etc/openclash/core/clash_meta

#将AdGuardHome核心文件编译进目录
curl -s https://api.github.com/repos/AdguardTeam/AdGuardHome/releases/latest \
| grep "browser_download_url.*AdGuardHome_linux_amd64.tar.gz" \
| cut -d : -f 2,3 \
| tr -d \" \
| xargs curl -L -o /tmp/AdGuardHome_linux_amd64.tar.gz && \
tar -xzvf /tmp/AdGuardHome_linux_amd64.tar.gz -C /tmp/ --strip-components=1 && \
mkdir -p files/usr/bin/AdGuardHome && \
mv /tmp/AdGuardHome/AdGuardHome files/usr/bin/AdGuardHome/
chmod 0755 files/usr/bin/AdGuardHome/AdGuardHome
