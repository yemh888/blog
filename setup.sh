#!/bin/bash
#

if [[ -d .git ]]; then
# create git hooks 
cat > .git/hooks/post-update <<EOF
#!/bin/bash

pwd > /tmp/test
#

EOF
else 
    echo "不是git项目"
fi
