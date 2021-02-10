#!/bin/bash
# sets up a pre-commit hook to ensure that vault.yaml is encrypted
# derived from https://github.com/IronicBadger/infra/blob/master/git-init.sh
# credit goes to nick busey from homelabos for this neat little trick
# https://gitlab.com/NickBusey/HomelabOS/-/issues/355

if [ -d .git/ ]; then
rm .git/hooks/pre-commit
cat  > .git/hooks/pre-commit <<EOL
for filename in ./**/*key* ./**/*tfstate*; do
    if ( cat \$filename | grep -q "\$ANSIBLE_VAULT;" ); then
        echo "[38;5;108mVault Encrypted. Safe to commit.[0m"
    else
        echo "[38;5;208mVault not encrypted! Run 'make encrypt' and try again.[0m"
    exit 1
    fi
done
EOL

fi

chmod +x .git/hooks/pre-commit
