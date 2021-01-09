#!/bin/bash
# use in Ubuntu

NEW_MIRROR='http://free.nchc.org.tw/ubuntu/'
OLD_MIRROR='http://archive.ubuntu.com/ubuntu/'
SOURCES_LIST='/etc/apt/sources.list'
PYENV_LINE_1='export PATH="$HOME/.pyenv/bin:$PATH"'
PYENV_LINE_2='eval "$(pyenv init -)"'
PYENV_LINE_3='eval "$(pyenv virtualenv-init -)"'
BASHRC="$HOME/.bashrc"

# Exit the script if error occurs
set -e

# Change mirror if hasn't been changed
if [ `sudo grep -c ${NEW_MIRROR} ${SOURCES_LIST}` = 0 ]; then
    sudo cp ${SOURCES_LIST} ${SOURCES_LIST}.tmp
    sudo sed -i "s|${OLD_MIRROR}|${NEW_MIRROR}|g" ${SOURCES_LIST}
    echo Change mirror to "${NEW_MIRROR}"
fi

echo 'Updating ubuntu and upgrading package'
sudo apt update
sudo  apt -y dist-upgrade

echo "Install requirements for pyenv"
sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev python-openssl git

# Switch to original user by here document
# sudo -i -u ${USER_NAME} bash << EOF

echo "Installing pyenv"
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
echo "${PYENV_LINE_1}" >> "${BASHRC}"
echo "${PYENV_LINE_2}" >> "${BASHRC}"
echo "${PYENV_LINE_3}" >> "${BASHRC}"

pyenv update

echo "Set python version to 3.8.1"
pyenv install 3.8.1
pyenv global 3.8.1

echo "Tinstallation succes. Please restart terminal."

# EOF
