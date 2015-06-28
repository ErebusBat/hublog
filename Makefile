####################################################################
## Defines
####################################################################
REMOTE = origin
BRANCH = master
SITE_URL=http://www.ErebusBat.com

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
	hugo

pushgh:
	git push $(REMOTE) $(BRANCH)

deploy: build pushgh
	cd public; \
		make deploy

open:
		open $(SITE_URL)
