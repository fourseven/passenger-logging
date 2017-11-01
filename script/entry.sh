#!/bin/sh

export HOST=$(curl -s 169.254.169.254/latest/meta-data/instance-id)
export LOCAL_IP=$(curl -s 169.254.169.254/latest/meta-data/local-ipv4)

exec "$@"
