**This repository contains various configuration files**

Owner: Dilan Fernando <dilan.fd@gmail.com>

## Requirements
- Git
- Curl

## Install
Install config tracking in your $HOME by running:

`curl -Lks http://bit.do/myConfigInstall | /bin/bash`

Or if that somehow doesn't work by explicitely running
the install script

```
git clone --bare https://github.com/dilanfd/dotfiles $HOME/.myconfig
function config {
   $(which git) --git-dir=$HOME/.myconfig/ --work-tree=$HOME $@
}
mkdir -p .config-backup
config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;
config checkout
config config status.showUntrackedFiles no
```
