SERVER_HOST := "server03.baty.net"
SERVER_USER := "root"
SERVER_DIR := "/srv/jackbaty.com/public_html/books"
LOCAL_DIR := "/Users/jbaty/Sync/sites/books/public"
TARGET_DIR := "/Users/jbaty/Sync/sites/books/public"
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
	git add -A
	git commit -m "Build site `date`"

push:
	@echo "\033[0;32mPushing repo\033[0m"
	git push origin main

