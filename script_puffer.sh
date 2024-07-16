#!/bin/bash

read -p "Введите пароль для валидатора: " password

read -p "Введите приватник метамаска: " private

read -p "Введите адресс метамаска: " address

read -p "Введите количество оперативы для загрузки файла: " RAM

read -p "Введите комманду с сайта: " command


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

echo $password > password.txt

modified_command=$(echo "$original_command" | sed 's|<PATH_TO_A_KEYSTORE_PASSWORD_FILE>|password.txt|g' | sed 's|<PATH_TO_REGISTRATION_JSON>|registration.json|g')

eval "$modified_command"

cd

openssl rand -hex 32 | tr -d "\n" > "/tmp/jwtsecret"

echo $private > /tmp/jwtsecret

unset private

cd

git clone https://github.com/status-im/nimbus-eth2

cd nimbus-eth2

make -j$RAM nimbus_beacon_node
#mainnet
build/nimbus_beacon_node trustedNodeSync \
 --network:mainnet \
 --data-dir=build/data/shared_mainnet_0 \
 --trusted-node-url=https://mainnet-checkpoint-sync.stakely.io

./run-mainnet-beacon-node.sh --web3-url=http://127.0.0.1:8551 --suggested-fee-recipient=$address --jwt-secret=/tmp/jwtsecret &
PROGRAM_PID=$!

sleep 120

kill $PROGRAM_PID

cd ~/puffer/coral/etc/keys/bls_keys

# Получение имени BLS ключа и сохранение его в переменную
BLS_KEY=$(ls | head -n 1)

# Проверка, что переменная не пустая
if [ -z "$BLS_KEY" ]; then
    echo "BLS ключ не найден!"
    exit 1
fi

cp -v ~/puffer/coral/etc/keys/bls_keys/$BLS_KEY ~/nimbus-eth2/build/data/shared_mainnet_0/validators/

mkdir ~/nimbus-eth2/validator_keys/ && cp -v ~/puffer/coral/etc/keys/bls_keys/$BLS_KEY ~/nimbus-eth2/validator_keys/keystore.json

cd

wget https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb -O packages-microsoft-prod.deb

sudo dpkg -i packages-microsoft-prod.deb

sudo apt-get update

sudo apt-get install -y dotnet-sdk-8.0 dotnet-runtime-8.0

dotnet --list-sdks
dotnet --list-runtimes

git clone https://github.com/NethermindEth/nethermind.git

cd nethermind/src/Nethermind/
dotnet build Nethermind.sln -c Release

cd


