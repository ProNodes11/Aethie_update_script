#!/bin/bash

sudo apt update && sudo apt upgrade -y

sudo apt install libssl-dev pkg-config build-essential curl git-lfs cmake -y

sudo curl https://sh.rustup.rs -sSf | sh -s -- -y

source $HOME/.cargo/env

echo "export PATH=\"$HOME/.cargo/bin:$PATH\"" >> ~/.bashrc
source ~/.bashrc

export OPENSSL_DIR=/usr/include/openssl
echo "export OPENSSL_DIR=/usr/include/openssl" >> ~/.bashrc
source ~/.bashrc
export OPENSSL_LIB_DIR=/usr/lib/x86_64-linux-gnu
export OPENSSL_INCLUDE_DIR=/usr/include/openssl
echo "export OPENSSL_LIB_DIR=/usr/lib/x86_64-linux-gnu" >> ~/.bashrc
echo "export OPENSSL_INCLUDE_DIR=/usr/include/openssl" >> ~/.bashrc
source ~/.bashrc

mkdir puffer
cd puffer

git clone https://github.com/PufferFinance/coral

cd coral
cargo build --release

echo AA123gAd123AA! > password.txt
