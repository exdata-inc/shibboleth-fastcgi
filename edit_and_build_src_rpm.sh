#!/bin/bash

# ソースRPMファイルのパス
SRC_RPM="/app/shibboleth-3.5.0-1.el7.src.rpm"

# 必要なパッケージをインストール
sudo dnf install -y rpmdevtools rpmbuild

# RPMビルド環境のセットアップ
rpmdev-setuptree

# ソースRPMを展開
rpm -i $SRC_RPM

# SPECファイルのパス
SPEC_FILE=~/rpmbuild/SPECS/shibboleth.spec

# "BuildRequires: httpd-devel%{?_isa}" を "BuildRequires: httpd-devel" に置き換える
sed -i 's/BuildRequires: httpd-devel%{?_isa}/BuildRequires: httpd-devel/' $SPEC_FILE

# 新しいRPMをビルド
rpmbuild -bs $SPEC_FILE

# 修正された .src.rpm ファイルのパス
NEW_SRC_RPM=$(find ~/rpmbuild/SRPMS/ -name "shibboleth*.src.rpm")

# move
mv -f $NEW_SRC_RPM /app/shibboleth.src.rpm

