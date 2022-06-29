#!/bin/bash

# Creating the Helper Script
cat >/opt/harness-delegate/kubectl_helper.sh <<EOL
#!/bin/bash

REAL_KUBECTL_BINARY_PATH=/opt/harness-delegate/client-tools/kubectl/v1.13.2/kubectl

if [[ "\$2" = "apply" ]]; then
        command="\$REAL_KUBECTL_BINARY_PATH \$@ --force"
else
        command="\$REAL_KUBECTL_BINARY_PATH \$@"
fi

\$command
EOL

chmod 777 /opt/harness-delegate/kubectl_helper.sh
