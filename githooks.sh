#!/bin/bash

set -e

ROOTDIR="$(cd "$(dirname "$0")"; pwd)"

function githooks_check_env() {
    if ! test -d .git; then
        echo ""
        echo "We cannot found git repository"
        echo ""
        echo "Try follow:"
        echo " $ cd <path-to-your-project>"
        echo ""

        exit 1
    fi
}

function githooks_install() {
    githooks_check_env

    cp $ROOTDIR/githookcfg .githookcfg

    ln -s $ROOTDIR/hooks/pre-push.sh .git/hooks/pre-push
    ln -s $ROOTDIR/hooks/commit-msg.sh .git/hooks/commit-msg
    ln -s $ROOTDIR/hooks/prepare-commit-msg.sh .git/hooks/prepare-commit-msg
}

function githooks_version() {
    pushd "$ROOTDIR" > /dev/null

    branch=$(git symbolic-ref --short HEAD)
    sha=$(git rev-parse --short HEAD)
    tag=$(git tag --points-at HEAD)

    if test -z "$tag"; then
        echo "$branch:$sha"
    else
        echo "v$tag ($branch:$sha)"
    fi

    popd > /dev/null
}

function githooks_help() {
    echo ""
    echo "githooks - configure hooks"
    echo ""
    echo "          init - initialize hooks for your repository"
    echo "                 and add config into project"
    echo "       version - show version of project"
    echo "          help - show this message"
    echo ""

    exit 1
}

do_init=false

for opt in "$@"; do
    case $opt in
        init|--init) do_init=true;;
        help|--help) githooks_help;;
        version|--version) echo "$(githooks_version)"; exit 0;;
        *) echo "Unrecognized option: '$opt'"; githooks_help;;
    esac
done

if [[ $do_init == "true" ]]; then
    githooks_install
fi