#/bin/bash

echo "Input Your Site Name:\c"
read site_name
echo "Input your commit comment: \c"
read commit_comment
cd /data/www/$site_name/public

git add -A
git commit -m $commit_comment
git push origin master
