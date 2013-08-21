#!/bin/bash

set -x

# Takes one argument of the type (role)
type=$1

echo "Creating a temporary directory..."
DIR=$(mktemp -d) || { echo "Couldn't create a temporary directory. Check permissions."; exit 1; }
mkdir -p $DIR/etc/puppet/{modules,manifests}

echo "Moving modules into the tmp dir..."
mv modules/* $DIR/etc/puppet/modules/

echo "Moving $TYPE node def into the tmp dir..."
mv manifest/${TYPE}.pp $DIR/etc/puppet/manifests/${TYPE}.pp

echo "Building a RPM..."
fpm -s dir -t rpm -v 0.0.1 -n puppetmodules -C $DIR etc/puppet
