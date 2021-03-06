####################################################################
## Defines
####################################################################
REMOTE = origin
BRANCH = master
SITE_URL=http://www.ErebusBat.com
LOCAL_URL=http://127.0.0.1:1313/
DWROOT=/data/opt/wiki/data/pages

################################################################################
## Targets
################################################################################
default: build

build: iscommited clean buildit

iscommited:
	git diff-files --quiet --ignore-submodules --

clean:
	cd public; \
		make clean

buildit:
	hugo --buildDrafts=false --buildFuture=false

pushgh:
	git push $(REMOTE) $(BRANCH)

pub: deploy
publish: deploy
deploy: build pushgh
	cd public; \
		make deploy

open:
	open $(SITE_URL)

preview:
	open $(LOCAL_URL)

edit:
	@fname=$$(git status -s | grep content/ | cut -c4-9999)
	@echo "Editing file $(fname)"
	vim $$(git status -s | grep content/ | cut -c4-9999)

dokutree:
	tree $(DWROOT)

new:
	ASK=1 script/newpost.zsh

convert:
	# CONVERT HINT
	#######################################################
	# make dokutree
	# export DWROOT=$(DWROOT)
	# script/doku2gh convert --meta $$DWROOT/pgsql/start.txt
