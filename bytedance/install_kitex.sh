#!/usr/bin/env bash

if [ "$(which go)" != "" ]; then
  go install code.byted.org/kite/kitex/tool/cmd/kitex@latest
  go install github.com/cloudwego/thrift-gen-validator@latest
  go install github.com/cloudwego/thriftgo@latest
fi

