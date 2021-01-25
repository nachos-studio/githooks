#### Why?

The goal of this project is for you to quickly organize the verification of
commit messages, as well as protect your branches from push on the client
side, so that they correspond to a certain format, without headaches,
a simple config file, without unnecessary dependencies, and also without:
`npm`, `python`, `ruby` and etc with submodules that weighs half the Internet.

#### Install githooks

```bash
git clone --depth=1 https://github.com/nachos-studio/githooks.git ~/.githooks
echo "export PATH=~/.githooks:\$PATH" >> ~/.bashrc
```

#### Prepare githooks for your repository

```bash
cd <you-project>
githooks init

# Edit configuration file
vim .githooks
```

#### Example of config with follow requirements:

* Allow push only to `{feature,bug,hotfix}/PRJ-XXX-branch-name`
* Guess Jira ID issue by branch name
* Validate commit message

```bash
# Allow push to specific branches
CONFIG_ALLOW_BRANCHES=(
    "/feature/PRJ-[0-9]+.+"
    "/bug/PRJ-[0-9]+.+"
    "/hotfix/PRJ-[0-9]+.+"
)

# Used for guess Jira ID by branch name & insert specific delimeter
CONFIG_COMMIT_MESSAGE_BUG_ID="PRJ-[0-9]+"
CONFIG_COMMIT_MESSAGE_BUG_ID_DELIMETER=": "

# Validate commit messages
CONFIG_COMMIT_MESSAGE_REQUIREMENTS=(
    "^$CONFIG_COMMIT_MESSAGE_BUG_ID:\ .+"
)
```
