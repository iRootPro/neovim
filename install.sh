#!/bin/bash

set -euo pipefail

if [ -z "${1+x}" ]; then
    VERSION=$(curl -s "https://nexus.sbmt.io/service/rest/v1/search?repository=paas-sbm-cli&group=/install/*" \
    | grep '"name"' | perl -p -e 's#.*"name" : "/install/(\S+)/install.sh",.*#$1#g' | sort --version-sort | tail -n1)
else
    VERSION=$(curl -s "https://nexus.sbmt.io/service/rest/v1/search?repository=paas-sbm-cli&group=/install/*" \
    | grep '"name"' | perl -p -e 's#.*"name" : "/install/(\S+)/install.sh",.*#$1#g' | sort --version-sort | grep "$1")
fi

# Проверка значения переменной VERSION перед финальным вызовом curl
if [ -z "$VERSION" ]; then
    echo "Version not found"
    exit 1
fi

USR_BIN_DIR=$HOME/.sbm-cli/usr/bin
rm -f "${USR_BIN_DIR}/sbm-cli"

curl -s "https://nexus.sbmt.io/repository/paas-sbm-cli/install/${VERSION}/install.sh" | bash
