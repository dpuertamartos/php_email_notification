#!/bin/bash
# Activate virtual environment
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Activate virtual environment
source "$DIR/venv/bin/activate"
cd $DIR
# Run python script
sudo ./venv/bin/python ./main.py









