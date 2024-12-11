#!/bin/bash

set -euo pipefail

if [ -z "${1+x}" ]; then
    VERSION=$(curl -s "https://nexus.sbmt.io/service/rest/v1/search?repository=paas-sbm-cli&group=/install/*" \
    | grep '"name".*install.sh' | perl -p -e 's#\s*"name" : "install/(\S+)/install.sh",#$1#g' | sort --version-sort | tail -n1)
else
    VERSION=$(curl -s "https://nexus.sbmt.io/service/rest/v1/search?repository=paas-sbm-cli&group=/install/*" \
    | grep '"name".*install.sh' | perl -p -e 's#\s*"name" : "install/(\S+)/install.sh",#$1#g' | sort --version-sort | grep "$1")

    USR_BIN_DIR=$HOME/.sbm-cli/usr/bin

    rm ${USR_BIN_DIR}/sbm-cli
fi

curl -s https://nexus.sbmt.io/repository/paas-sbm-cli/install/${VERSION}/install.sh | bash