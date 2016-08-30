# 各環境に tmux で ssh する

peco のインストールが必要

## Usage

```bash
# $HOME/.birdfirm/hosts/project-environment-host
#!/bin/bash

ssh 192.168.1.100
```

./bin/birdfirm.sh で $HOME/.birdfirm/hosts 設置してあるファイルを peco で選択して実行する
