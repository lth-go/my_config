# zsh目录
export ZSH=$HOME/.oh-my-zsh

# 补全大小写敏感
CASE_SENSITIVE="true"

# 主题
ZSH_THEME="lth"

# 插件
# git://github.com/zsh-users/
plugins=(git docker docker-compose z sudo pip zsh-completions zsh-autosuggestions zsh-syntax-highlighting)

# 用户配置

export PATH=$HOME/bin:/usr/local/bin:$PATH

source $ZSH/oh-my-zsh.sh

# 设置环境语言
export LANG=zh_CN.utf8

# zsh-completions 需要
autoload -U compinit && compinit

export PYPI_USER=jcing
export PYPI_PWD=Fg1_02DJcinw@1as

# docker
alias dps="docker ps --format \"table {{.Names}}\t{{.Image}}\t{{.ID}}\t{{.Status}}\""

# Vim
alias vi='vimx'
alias vim='vimx'

# 搜索
bindkey '^p' up-line-or-beginning-search
bindkey '^n' down-line-or-beginning-search
