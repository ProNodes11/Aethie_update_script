#!/bin/bash

sudo rm -rf AethirCheckerCLI-linux-1.0.2.0-eu.tar.gz AethirCheckerCLI-linux-eu

wget https://checker-mainet-s3.s3.ap-southeast-1.amazonaws.com/eu/AethirCheckerCLI-linux-1.0.2.3.tar.gz

tar -xvf AethirCheckerCLI-linux-1.0.2.3.tar.gz

cd AethirCheckerCLI-linux-1.0.2.3/

sudo ./install.sh
