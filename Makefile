####################################################################
## Defines
####################################################################
REMOTE = origin
BRANCH = master

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
