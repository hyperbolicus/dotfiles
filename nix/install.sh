#!/bin/bash


TARGET=$HOME/.config/nixpkgs/overlays/

mkdir -p $TARGET

cp -vr . $TARGET
