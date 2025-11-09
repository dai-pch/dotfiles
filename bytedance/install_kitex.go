#!/bin/bash

if [ "$(which go)" != "" ]; then
  go install code.byted.org/kite/kitex/tool/cmd/kitex@latest
fi

