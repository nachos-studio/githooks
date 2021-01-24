# Project: minimal git flow checkers
#
# Author: Nikita Somenkov <somenkov.nikita@icloud.com>
#

PROJECT_DIR="$(git rev-parse --show-toplevel)"
if test -f $PROJECT_DIR/.githookcfg; then
    source $PROJECT_DIR/.githookcfg
fi

if test -z "${CONFIG_ALLOW_BRANCHES}"; then
    exit 0
fi

CURRENT_BRANCH=$(git symbolic-ref HEAD)

remote_name="$1"
repository_url="$2"

for allow_branch in "${CONFIG_ALLOW_BRANCHES[@]}"; do
    if echo "$CURRENT_BRANCH" | grep -Eq "$allow_branch"; then
        exit 0
    fi
done

echo "hint: Do not allow push to protected branch: $CURRENT_BRANCH."
echo "hint: "
echo "hint: If you understand what you are doing and really want to continue:"
echo "hint: For continue use: git push --no-verify"
exit 1
