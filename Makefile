deploy:
	hugo 
	cp -r public/ docs
	git add -A
	git commit -m "Deploy"
	git push origin master --force
