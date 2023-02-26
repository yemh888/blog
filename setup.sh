#!/bin/bash
#

if [[ -d .git ]]; then
# create git hooks 
cat > .git/hooks/pre-push <<EOF
#!/bin/bash

read local_ref local_oid remote_ref remote_oid
if [ "\$local_ref" == "refs/heads/main" ]; then
    exit 0
fi

TMP_DIR=\$(mktemp -d)
GIT_DIR=\$(pwd)
DATA_DIR="\$(pwd)/public/"

hexo g
cd \$TMP_DIR && git clone --branch=main \$GIT_DIR data
rsync -av --del --exclude ".git" --exclude ".github" \$DATA_DIR data/
cd data && git add . && git commit -m "\$(date +%Y%m%d%H%M%S)" && git push && cd \$GIT_DIR
sudo rm \$TMP_DIR -rf
git push origin main
exit 0

EOF
else 
    echo "不是git项目"
fi
