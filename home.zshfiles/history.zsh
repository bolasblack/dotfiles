#������ʷ��¼������ 
#��ʷ��¼��Ŀ����
export HISTSIZE=10000
#ע���󱣴����ʷ��¼��Ŀ����
export SAVEHIST=10000

# ���庯�����滻ԭ���� cd 
cd() {
    builtin cd "$@"                             # ִ��ԭ���� cd ����
    fc -W                                       # д��ʷ��¼�ļ���Ĭ�ϲ���Ϊ $HISTFILE ����ʼֵΪ #2 ���Ķ��壻ִ���� cd �����Ϊ #1 ���Ķ���
# ʵ���ϣ��㲻������ÿ��Ŀ¼�¶�ִ�и�������ܶ�Ŀ¼��û��ȥ����ֻҪΪ��ȥ����Ŀ¼������ʷ��¼�Ϳ�����
    local HISTDIR="$HOME/.zsh_history$PWD"      # ������ʷ��¼Ŀ¼��ÿ�� cd ��$PWD ��Ӧ�빤��Ŀ¼�㼶��ͬ��Ŀ¼
        if  [ ! -d "$HISTDIR" ] ; then          # ������������Ŀ¼������һ��
            mkdir -p "$HISTDIR"
        fi
        export HISTFILE="$HISTDIR/zhistory"     #1 ������ʷ��¼�ļ�  
    touch $HISTFILE                        		# �� touch һ�£���������ڵĻ��ͻ��½�һ��
# ���ԭ������ʷ��¼
    local ohistsize=$HISTSIZE               	# �趨һ��������ʱ�洢ԭ��ʷ��¼��С
        HISTSIZE=0                              # ͨ��������ʷ��¼���
        HISTSIZE=$ohistsize                     # �����趨��ʷ��¼��С
    fc -R                                       #����ʷ��¼�ļ���Ĭ�ϲ���Ϊ $HISTFILE  ��Ҳ���� #1 ���Ķ���
}
# ���� zsh ��ʱ�򣬲�û��ִ�� cd ������ $HOME Ŀ¼��Ӧ����ʷ��¼Ŀ¼���ܲ����ڣ��Ƚ�����
mkdir -p $HOME/.zsh_history$PWD
#2 ͬ�������� zsh ��ʱ�� ��û�ж��� $HOME Ŀ¼��Ӧ�� $HISTFILE �������ȶ�����
export HISTFILE="$HOME/.zsh_history$PWD/zhistory"

# ʹ�� setopt EXTENDED_HISTORY ѡ�Ϊ�������ʱ��� 
# ��ǳ���Ҫ�����ܵ�һ�����ʷ��¼�Ƚϻ��ң�ʱ������������������ 

# ���� allhistory �������е���ʷ��¼���ܵ�һ��
function allhistory { cat $(find $HOME/.zsh_history -name zhistory) }
# �����ʷ��¼�ĸ�ʽ����ת��
function convhistory {
            sort $1 |  		#����
            uniq |      	#�ϲ���ͬ�С�
                          	#����ʱ�����ȷ���룬���Լ�������������ͬ�ļ�¼
                          	#������ͬ�ļ�¼����Ϊ zsh �Ĵ���ʽ��ÿ�� cd ����������¼�ļ��в�����ͬ�� cd ����
            sed 's/^:\([ 0-9]*\):[0-9]*;\(.*\)/\1::::::\2/' |   #ȥ����ʷ��¼�в���Ҫ���ֶΡ�����Զ���ķָ�����������һ������
            awk -F"::::::" '{ $1=strftime("%Y-%m-%d %T",$1) "|"; print }'    # �� UNIX ʱ���ת���ɿ��Կ����ĸ�ʽ
}

#ʹ�� histall ����鿴ȫ����ʷ��¼
function histall { convhistory =(allhistory) |
            sed '/^.\{20\} *cd/i\\' }  # ��ÿ�� cd ����ǰ��ӿ��У��жϹ���Ŀ¼�Ƚ����� 
                                       # ���ܻ���һ�㲻׼ȷ����Ϊ�������˳�ʱ��ִ�� cd ���û����Ӧ�ļ�¼��������ͬʱ���ж�� zsh  ��ʱ��
#ʹ�� hist �鿴��ǰĿ¼��ʷ��¼
function hist { convhistory $HISTFILE }

# vim:filetype=zsh expandtab shiftwidth=4
