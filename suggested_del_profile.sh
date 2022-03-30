#!/bin/bash

# Installing a HELM 3 binary
curl -o /tmp/helm-v3.8.0-linux-amd64.tar.gz https://get.helm.sh/helm-v3.8.0-linux-amd64.tar.gz
mkdir -p /opt/harness-delegate/custom-client-tools/helm/v3.8.0

tar -zxvf /tmp/helm-v3.8.0-linux-amd64.tar.gz -C /tmp/
mv /tmp/linux-amd64/helm /opt/harness-delegate/custom-client-tools/helm/v3.8.0/
chmod 777 /opt/harness-delegate/custom-client-tools/helm/v3.8.0/
rm -rf /tmp/linux-amd64


# Creating the Helper Script
cat >/opt/harness-delegate/helm_helper.sh <<EOL
#!/bin/bash

#REAL_HELM_BINARY_PATH=/usr/local/bin/helm
REAL_HELM_BINARY_PATH=/opt/harness-delegate/custom-client-tools/helm/v3.8.0/helm

if [[ "\$1" = "repo" && "\$2" = "add" && ! "\$@" =~ "--force-update" ]]; then
        command="\$REAL_HELM_BINARY_PATH \$@ --force-update"
else
        command="\$REAL_HELM_BINARY_PATH \$@"
fi

\$command
EOL

chmod 777 /opt/harness-delegate/helm_helper.sh
