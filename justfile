SERVER_HOST := "bsd01.baty.net"
SERVER_USER := "jbaty"
SERVER_DIR := "/usr/local/www/jackbaty.com/public_html/books"
LOCAL_DIR := "/Users/jbaty/Documents/Notes/books/public_html"
TARGET := "Hetzner"

default:
	just --list

build:
	pandoc -s books.md --css=pandoc.css -o {{LOCAL_DIR}}/index.html


deploy: build commit push
	@echo "\033[0;32mDeploying updates...\033[0m"
	rsync -v -rz --checksum --delete --no-perms {{LOCAL_DIR}}/ {{SERVER_USER}}@{{SERVER_HOST}}:{{SERVER_DIR}}

commit:
	@echo "\033[0;32mAdding changes\033[0m"
	git add .
	git diff-index --quiet HEAD || git commit -m "Build site `date`"

push:
	@echo "\033[0;32mPushing repo\033[0m"
	git push origin main

