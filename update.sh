#!/usr/bin/env bash
set -euo pipefail

export CVS_RSH=ssh
export CVSIGNORE="\
	readme \
	update.sh \
"

# Initial checkout done using:
#   cvs -d anoncvs@anoncvs.ca.openbsd.org:/cvs/src/usr.sbin/acme-client checkout -P .

set +u
. /usr/lib/git-core/git-sh-setup
require_clean_work_tree "update from openbsd tree"
set -u

git checkout openbsd

cvs up -PAd

backup_regex='^\?\? \.#.*\.[0-9]+\.[0-9]+$'
if git status -z --untracked-files --porcelain | egrep -z "$backup_regex"; then
	git status -z --untracked-files --porcelain \
		| egrep -z "$backup_regex" \
		| cut -zb4- \
		| xargs -0rx rm -v --
fi

if [ -n "$(git status --porcelain)" ]; then
	echo "Some changes present, commiting."
	git add .
	git commit -m "Update from openbsd ($(date -u '+%Y-%d-%m %H:%M:%S') UTC)"
fi
