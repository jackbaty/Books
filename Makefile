SERVER_HOST=books.baty.net
SERVER_DIR=/home/jbaty/apps/books.baty.net/public_html
LOCAL_DIR=/Users/jbaty/sites/books.baty.net
TARGET=DigitalOcean

build:
	pandoc -s books.md --css=pandoc.css -o index.html


deploy: build commit push
	@echo "\033[0;32mDeploying updates...\033[0m"
	rsync -v -rz --checksum --delete --no-perms $(LOCAL_DIR)/index.html $(SERVER_HOST):$(SERVER_DIR)

commit:
	@echo "\033[0;32mAdding changes\033[0m"
	git add -A
	git commit -m "Build site `date`"

push:
	@echo "\033[0;32mPushing repo\033[0m"
	git push origin main


.FORCE:
