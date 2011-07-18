# -*- Shell-script -*-
####################################### S* ������ʷ��¼������
#��ʷ��¼��Ŀ���
export HISTSIZE=10000
#ע��󱣴����ʷ��¼��Ŀ���
export SAVEHIST=10000
#��ʷ��¼�ļ�
#export HISTFILE=~/.zhistory
#�Ը��ӵķ�ʽд����ʷ��¼
setopt INC_APPEND_HISTORY
#�����������������ͬ����ʷ��¼��ֻ����һ��
setopt HIST_IGNORE_DUPS
#Ϊ��ʷ��¼�е��������ʱ���
setopt EXTENDED_HISTORY

#ÿ��Ŀ¼ʹ�ö������ʷ��¼
cd() {
    builtin cd "$@"                             # do actual cd
    fc -W                                       # write current history file
    local HISTDIR="$HOME/.zsh_history/$PWD"      # use nested folders for history
        if  [ ! -d "$HISTDIR" ] ; then          # create folder if needed
            mkdir -p "$HISTDIR"
        fi
        export HISTFILE="$HISTDIR/zhistory"     # set new history file
    touch $HISTFILE
    local ohistsize=$HISTSIZE
        HISTSIZE=0                              # Discard previous dir's history
        HISTSIZE=$ohistsize                     # Prepare for new dir's history
    fc -R                                       #read from current histfile
}
mkdir -p $HOME/.zsh_history/$PWD
export HISTFILE="$HOME/.zsh_history/$PWD/zhistory"

function allhistory { cat $(find $HOME/.zsh_history/$PWD -name zhistory) }
function convhistory {
            sort $1 | uniq |
            sed 's/^:\([ 0-9]*\):[0-9]*;\(.*\)/\1::::::\2/' |
            awk -F"::::::" '{ $1=strftime("%Y-%m-%d %T",$1) "|"; print }'  
}
#ʹ�� histall ����鿴ȫ����ʷ��¼
function histall { convhistory =(allhistory) |
            sed '/^.\{20\} *cd/i\\' }
#ʹ�� hist �鿴��ǰĿ¼��ʷ��¼
function hist { convhistory $HISTFILE }

#ȫ����ʷ��¼ top44
function top44 { allhistory | awk -F':[ 0-9]*:[0-9]*;' '{ $1="" ; print }' | sed 's/ /\n/g' | sed '/^$/d' | sort | uniq -c | sort -nr | head -n 44 }

#���� cd �������ʷ��¼��cd -[TAB]������ʷ·��
setopt AUTO_PUSHD

####################################### E* ������ʷ��¼������

