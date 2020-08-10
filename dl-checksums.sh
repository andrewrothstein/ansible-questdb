#!/usr/bin/env sh
set -e
DIR=~/Downloads
MIRROR=https://github.com/questdb/questdb/releases/download

dl()
{
    local ver=$1
    local dist=$2
    local os=$3
    local arch=$4
    local platform="${os}-${arch}"
    local file="questdb-${ver}-${dist}-${platform}.tar.gz"
    local url=$MIRROR/$ver/$file
    local lfile=$DIR/$file
    if [ ! -e $lfile ];
    then
        wget -q -O $lfile $url
    fi
    printf "    # %s\n" $url
    printf "    %s: sha256:%s\n" $platform $(sha256sum $lfile | awk '{print $1}')
}

dl_ver() {
    local ver=$1
    printf "  '%s':\n" $ver
    dl $ver rt freebsd amd64
    dl $ver rt linux amd64
    dl $ver rt osx amd64
    dl $ver rt windows amd64
}

dl_ver ${1:-5.0.2}
