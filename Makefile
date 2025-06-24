


release:
	@git add .
	@git commit -am "New release!" || true
	@git push
	@git pull
	@#git tag -f -a "0.1.0" -m "New release!"
	@#git push origin "0.1.0" -f --tags
