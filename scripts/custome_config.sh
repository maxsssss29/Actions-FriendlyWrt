#!/bin/bash
set -e

CONFIG="configs/rockchip/01-nanopi"

sed -i -e '/CONFIG_MAKE_TOOLCHAIN=y/d' "$CONFIG"
sed -i -e 's/CONFIG_IB=y/# CONFIG_IB is not set/g' "$CONFIG"
sed -i -e 's/CONFIG_SDK=y/# CONFIG_SDK is not set/g' "$CONFIG"

# OpenConnect VPN and HTTPS DNS Proxy packages
for package in openconnect luci-proto-openconnect https-dns-proxy luci-app-https-dns-proxy; do
    if ! grep -q "^CONFIG_PACKAGE_${package}=y$" "$CONFIG"; then
        echo "CONFIG_PACKAGE_${package}=y" >> "$CONFIG"
    fi
done
