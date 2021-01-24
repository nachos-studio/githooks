# Project: minimal git flow checkers
#
# Author: Nikita Somenkov <somenkov.nikita@icloud.com>
#

PROJECT_DIR="$(git rev-parse --show-toplevel)"
if test -f $PROJECT_DIR/.githookcfg; then
    source $PROJECT_DIR/.githookcfg
fi

if test -z "${CONFIG_COMMIT_MESSAGE_REQUIREMENTS}"; then
    exit 0
fi

message="$1"

for requirement in "${CONFIG_COMMIT_MESSAGE_REQUIREMENTS[@]}"; do
    if head -n 1 "$message" | grep -Eq "$requirement"; then
        exit 0
    fi
done

echo "hint: Message commit cannot confirm requirement"
for requirement in "${CONFIG_COMMIT_MESSAGE_REQUIREMENTS[@]}"; do
    echo "hint: $requirement"
done
echo "hint: But you commit message is: '$(head -n 1 "$message")'"
echo "hint: "
echo "hint: If you understand what you are doing and really want to continue:"
echo "hint: git commit --no-verify"
exit 1