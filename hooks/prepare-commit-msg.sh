# Project: minimal git flow checkers
#
# Author: Nikita Somenkov <somenkov.nikita@icloud.com>
#

PROJECT_DIR="$(git rev-parse --show-toplevel)"
if test -f $PROJECT_DIR/.githookcfg; then
    source $PROJECT_DIR/.githookcfg
fi

if test -z "${CONFIG_COMMIT_MESSAGE_BUG_ID}"; then
    exit 0
fi

CURRENT_BRANCH=$(git symbolic-ref HEAD)

commit_msg_file=$1
commit_source=$2
sha1=$3

function proccess_commit_message() {
    local bugidregexp=$CONFIG_COMMIT_MESSAGE_BUG_ID
    local delimeter=$CONFIG_COMMIT_MESSAGE_BUG_ID_DELIMETER

    # No need add bug id when it already done
    if head -n 1 "$commit_msg_file" | grep -Eo "$bugidregexp"; then
        exit 0
    fi

    current_bugid="$(echo $CURRENT_BRANCH | grep -Eo "$bugidregexp")"
    sed -i.bak -e "1s/^/$current_bugid$delimeter/" $commit_msg_file
}

proccess_commit_message
