plugins=(colored-man zsh-users/zsh-syntax-highlighting)

PLUGIND=$HOME/.antigen/repos
ANTIGEND=$PLUGIND/antigen

[ -d $PLUGIND ] || mkdir -p $PLUGIND
[ -d $ANTIGEND ] || git clone --depth=1 https://github.com/zsh-users/antigen.git $ANTIGEND
source $ANTIGEND/antigen.zsh

for plugin in $plugins; do
  antigen bundle $plugin
done
