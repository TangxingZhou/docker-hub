#!/usr/bin/env bash

set +x

workspace=$(cd `dirname $0`; pwd)


function get_help() {
    echo "Usage: run.sh [OPTIONS] COMMAND"
}


while [ $# -gt 0 ]
do
    key="$1"
    case $key in
    --deploy | -d)
        if [ $2 = "runtime" ]; then
            ansible-playbook -i hosts playbooks/k8s/deploy_runtime.yml
        elif [ $2 = "k8s" ]; then
            ansible-playbook -i hosts playbooks/k8s/deploy_cluster.yml
        elif [ $2 = "cluster-link" ]; then
            ansible-playbook -i hosts playbooks/qt/deploy_cluster_link.yml
        fi
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

