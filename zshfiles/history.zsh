# 历史纪录条目数量
export HISTSIZE=10000
# 注销后保存的历史纪录条目数量
export SAVEHIST=10000

# 定义函数，替换原来的 cd
cd() {
  builtin cd "$@"                             # 执行原来的 cd 命令
  fc -W                                       # 写历史纪录文件，默认参数为 $HISTFILE 。初始值为 #2 处的定义；执行了 cd 命令后为 #1 处的定义
  # 实际上，你不可能在每个目录下都执行个把命令，很多目录你没有去过，只要为你去过的目录建立历史纪录就可以了
  local HISTDIR="$HOME/.zsh_history$PWD"      # 定义历史纪录目录。每次 cd 后，$PWD 对应与工作目录层级相同的目录
  if  [ ! -d "$HISTDIR" ] ; then              # 如果不存在这个目录，则建立一个
    mkdir -p "$HISTDIR"
  fi
  export HISTFILE="$HISTDIR/zhistory"         #1 定义历史纪录文件
  touch $HISTFILE                             # 先 touch 一下，如果不存在的话就会新建一个
  # 清空原来的历史纪录
  local ohistsize=$HISTSIZE                   # 设定一个变量临时存储原历史纪录大小
  HISTSIZE=0                                  # 通过禁用历史纪录清空
  HISTSIZE=$ohistsize                         # 重新设定历史纪录大小
  fc -R                                       # 读历史纪录文件，默认参数为 $HISTFILE  。也就是 #1 处的定义
}
# 启动 zsh 的时候，并没有执行 cd 命令，因此 $HOME 目录对应的历史纪录目录可能不存在，先建立它
mkdir -p $HOME/.zsh_history$PWD
#2 同样，启动 zsh 的时候， 还没有定义 $HOME 目录对应的 $HISTFILE ，所以先定义它
export HISTFILE="$HOME/.zsh_history$PWD/zhistory"

# 使用 setopt EXTENDED_HISTORY 选项，为命令添加时间戳
# 这非常重要，汇总到一起的历史纪录比较混乱，时间戳是重新排序的依据
setopt EXTENDED_HISTORY

# 定义 allhistory ，将所有的历史纪录汇总到一起
function allhistory { cat $(find $HOME/.zsh_history -name zhistory) }
# 针对历史纪录的格式进行转换
function convhistory {
  sort $1 |       # 排序
  uniq |          # 合并相同行。
                  # 由于时间戳精确到秒，所以几乎不可能有相同的纪录
                  # 出现相同的纪录是因为 zsh 的处理方式，每次 cd 会在两个纪录文件中产生相同的 cd 命令
  sed 's/^:\([ 0-9]*\):[0-9]*;\(.*\)/\1::::::\2/' |                # 去掉历史纪录中不需要的字段。添加自定义的分隔符，方便下一步处理
  awk -F"::::::" '{ $1=strftime("%Y-%m-%d %T",$1) "|"; print }'    # 将 UNIX 时间戳转换成可以看懂的格式
}

# 使用 histall 命令查看全部历史纪录
function histall { convhistory =(allhistory) | sed '/^.\{20\} *cd/i\\' }  # 在每个 cd 命令前添加空行，判断工作目录比较容易
# 可能会有一点不准确。因为启动和退出时不执行 cd 命令，没有相应的纪录。尤其是同时运行多个 zsh 的时候
# 使用 hist 查看当前目录历史纪录
function hist { convhistory $HISTFILE }