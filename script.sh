#!/bin/bash

sudo rm -rf AethirCheckerCLI-linux-1.0.2.5-eu.tar.gz AethirCheckerCLI-linux-eu-1.0.2.5

wget https://checker-mainet-s3.s3.ap-southeast-1.amazonaws.com/eu/AethirCheckerCLI-linux-1.0.2.6.tar.gz

tar -xvf AethirCheckerCLI-linux-1.0.2.6.tar.gz

cd AethirCheckerCLI-linux-1.0.2.6/

sudo ./install.sh
