git checkout --orphan latest_branch
git add -A
git commit -am 'commit'
git branch -D master
git branch -D main
git branch -M main
git push -f origin main
git branch --set-upstream-to origin/main main
pause