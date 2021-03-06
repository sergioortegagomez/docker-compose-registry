#!/bin/bash 

function usage() {
    echo -e "usage: bin/platformcontrol.sh [up|destroy|ssh|status|halt]"
}

case $1 in
    up) vagrant up ;;
    destroy) vagrant destroy -f ;;
    ssh) vagrant ssh docker-registry.local ;;
    status) vagrant status ;;
    halt) vagrant halt ;;
    *) usage ;;
esac
