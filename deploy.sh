#!/bin/sh
# ./myblog/deploy.sh

# rsync to efficiently sync ./myblog/build to ./personalblog/
# ignore deleteing .git folder and other stuff
rsync -rtvu --delete -f"- .git/" -f"- CNAME" -f"- .gitignore" -f"- README.md" ./build/ /Users/jakes/Projects/jakestevenson.github.com


# change dir
cd /Users/jakes/Projects/jakestevenson.github.com

# sync to github
git add -A
git commit -am "Commit on $(date)"
git push origin master
