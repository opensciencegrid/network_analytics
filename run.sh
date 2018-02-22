#!/bin/bash

. /environment.sh

echo $PATH

git clone --recursive https://github.com/opensciencegrid/network_analytics.git

echo "========= all set up. ============"

cd network_analytics
ls
"$@"