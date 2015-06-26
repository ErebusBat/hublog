####################################################################
## Defines
####################################################################
REMOTE = origin
BRANCH = master
COMMIT_MSG = "Site Update"

################################################################################
## Targets
################################################################################
default: deploy

deploy: snapshot iscommited
deploy: snapshot iscommited pushgh

iscommited:
	git diff-files --quiet --ignore-submodules --

clean:
	rm -dfr *

snapshot:
	git add --all
	git status
	git commit -m $(COMMIT_MSG)

pushgh:
	git push $(REMOTE) $(BRANCH)
