#!/usr/bin/env bash

set -x

workspace=$(cd `dirname $0`; pwd)

PLATFORMS=linux/amd64,linux/arm64
repository=registry.qingteng.cn
group=hivetest
img_tag=latest
push=false

function get_help() {
    echo "Usage: build_image.sh [OPTIONS] COMMAND"
}

function buildx() {
    if [ $push = "true" ]; then
        docker buildx build --platform $PLATFORMS -t $repository/$2/$3:$4 $1/ --push
    else
        docker buildx build --platform $PLATFORMS -t $repository/$2/$3:$4 $1/ -o type=local,dest=.docker
    fi
}

function build() {
    local manifest_list=()
    OLD_IFS="$IFS"
    IFS=","
    local target_platforms=($PLATFORMS)
    for platform in ${target_platforms[@]}; do
        docker pull --platform $platform $1:$4
        docker tag $1:$4 $repository/$2/$3-${platform#*/}:$4
        manifest_list=($manifest_list $repository/$2/$3-${platform#*/}:$4)
    done
    IFS="$OLD_IFS"
    if [ $push = "true" ]; then
        for manifest in ${manifest_list[@]}; do
            docker push $manifest
        done
        docker manifest create --insecure $repository/$2/$3:$4 ${manifest_list[@]}
        docker manifest push -p --insecure $repository/$2/$3:$4
    fi
}

while [ $# -gt 0 ]
do
    key="$1"
    case $key in
    build | -b)
        build_path=$2
        build_path=${build_path/%\//}
        if [ -d $build_path ]; then
            src_img=${build_path##*/}
            dest_img=${build_path/#./}
            dest_img=${build_path/#\//}
            dest_img=${build_path//\//_}
        fi
        shift 2
        ;;
    --push | -p)
        push=true
        shift
        ;;
    --tag | -t)
        img_tag=$2
        shift 2
        ;;
    --repository | -r)
        repository=$2
        shift 2
        ;;
    --group | -g)
        group=$2
        shift 2
        ;;
    --help | -h)
        get_help
        shift
        exit 0
        ;;
    *)
        shift
        ;;
    esac
done

if [ -f $build_path/build.sh ]; then
    bash -x $build_path/build.sh $repository $group $dest_img $img_tag
else
    if [ -f $build_path/Dockerfile ]; then
        buildx $build_path $group $dest_img $img_tag
    else
        build $src_img $group $dest_img $img_tag
    fi
fi
