#!/bin/bash

set -e

if [ "$(uname -s)" = "Darwin" ] && [ "$(uname -m)" = "x86_64" ]; then
    target="x86_64-apple-darwin"
elif [ "$(uname -s)" = "Darwin" ] && [ "$(uname -m)" = "arm64" ]; then
    target="aarch64-apple-darwin"
elif [ "$(uname -s)" = "Linux" ] && [ "$(uname -m)" = "x86_64" ]; then
    target="x86_64-unknown-linux-musl"
elif [ "$(uname -s)" = "Linux" ] && [ "$(uname -m)" = "aarch64" ]; then
    target="aarch64-unknown-linux-musl"
elif [ "$(uname -s)" = "Linux" ] && ( uname -m | grep -q -e '^arm' ); then
    target="arm-unknown-linux-gnueabihf"
else
    echo "Unsupported OS or architecture"
    return
fi
echo "Detected target: $target"
