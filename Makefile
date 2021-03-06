SHELL=/bin/bash

.PHONY: run push test clean

SUPYBOT_EXEC ?= /usr/bin/supybot
DAEMON ?= --daemon
BOTNAME ?= wopr

run: $(BOTCONF) $(BOTDIR)/conf/users.conf
	$(SUPYBOT_EXEC) $(BOTCONFFILE) $(DAEMON)

test: $(BOTDIR)/conf/users.conf
	@#FIXME add supybot test here

push: clean
	git add --all
	git status
	git commit -a -m$(AUTOCOMMIT_MSG)
	git push $(BOTREMOTE) $(BOTBRANCH)

$(BOTDIR)/conf/users.conf:
	ifeq(,$(wildcard $@ ))
	$(error $@ is required for $(BOTNAME) to run. Please run make run from the auth data repository to run the bot.)
	endif

clean:
	@# noop
