export http_proxy=http://sys-proxy-rd-relay.byted.org:3128
export https_proxy=http://sys-proxy-rd-relay.byted.org:3128
# bj-rd-proxy.byted.org:3128
export NO_PROXY="localhost,.byted.org,byted.org,.bytedance.net,bytedance.net,127.0.0.1,127.0.0.0/8,169.254.0.0/16,100.64.0.0/10,172.16.0.0/12,192.168.0.0/16,10.0.0.0/8,::1,fe80::/10,fd00::/8"
export no_proxy=$NO_PROXY
export PS1="\[\e[0;33m\][\h \W]\$ \[\e[m\]"

# go 制品库
export GOPRIVATE="gitlab.everphoto.cn,sysrepo.byted.org"
export GONOSUMDB='*.byted.org'
export GOPROXY='https://goproxy.byted.org|direct'
export GONOPROXY='gitlab.everphoto.cn,sysrepo.byted.org' 

