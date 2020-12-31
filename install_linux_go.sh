#!/bin/bash

GO_INSTALL_PATH='/usr/local/go'
PROFILE_FILE='/etc/profile'
ZPROFILE_FILE='/etc/zsh/zprofile'
EXPORT_LINE='export PATH=$PATH:/usr/local/go/bin'
PWD=$(pwd)

GO_VERSION=${1:-'1.13.5'}
GO_TAR="go$GO_VERSION.linux-amd64.tar.gz"

DOWNLOAD_URL="https://dl.google.com/go/$GO_TAR"

# Delete Old Go Installation function
del_old_go () {
  if [ -d $GO_INSTALL_PATH ]; then
    sudo rm -rf $GO_INSTALL_PATH
  fi
}

# Install Golang
install_go () {
  if [ -f "$PWD/$GO_TAR" ]; then
    # Delete old Go
    del_old_go
    echo "Installing go $GO_VERSION"
    sudo tar -C /usr/local -xzf "$PWD/$GO_TAR"
    rm "$PWD/$GO_TAR"
    echo "Golang $GO_VERSION installed"
    if [ -d $GO_INSTALL_PATH ]; then
      if [[ -z $(grep "$EXPORT_LINE" "$PROFILE_FILE") ]]; then
        echo $EXPORT_LINE | sudo tee -a $PROFILE_FILE > /dev/null
      fi
      if [[ -z $(grep "$EXPORT_LINE" "$ZPROFILE_FILE") ]]; then
        echo $EXPORT_LINE | sudo tee -a $ZPROFILE_FILE > /dev/null
      fi
    fi
  fi
}

# Check if file is available on server
STATUS=$(curl --head --silent $DOWNLOAD_URL | head -n 1 | awk '{print $2}')

# Download file if on Google Go server
if [ $STATUS == '200' ]; then
  curl -LO $DOWNLOAD_URL # Download Go
  install_go # installing go
else
  echo "Golang version $GO_VERSION was not found on the server"
  exit 1
fi
