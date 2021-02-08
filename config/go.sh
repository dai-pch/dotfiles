if [[ "$HAS_GO" == "1" ]]; then
    export GOPATH="$HOME/workspace/go"
    export GOROOT="$HOME/.local/go"
    export PATH="$PATH:$GOROOT/bin:$GOPATH/bin"
    export GO111MODULE="on"
    export GOPROXY="https://goproxy.cn,direct"
    export GOPRIVATE="github.com/dai-pch,github.com/StayFoolish-and-Hungry"
fi

