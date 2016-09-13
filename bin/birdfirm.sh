#!/bin/bash

birdfirm_main(){
  local root
  local hosts
  local hostfile
  local socket
  local session
  local path
  root=$HOME/.birdfirm/hosts
  hosts=$root.txt

  if [ -f $hosts ]; then
    echo "birdfirm locked. maybe running? (lock file : $hosts)"
    return
  fi

  if [ -d "$root" ]; then
    while [ true ]; do
      ls -1 $root | awk '{print "  " $1}' > $hosts
      for socket in $HOME/.tmux.wrapper/tmux-*.sock; do
        for session in $(tmux -S $socket ls -F '#S' 2> /dev/null); do
          sed "s/^  $session$/* $session/" -i $hosts
        done
      done
      hostfile=$(cat $hosts | peco)
      hostfile=${hostfile##* }
      if [ "$hostfile" ]; then
        path=$root/$hostfile
        if [ -f "$path" ]; then
          $path
        fi
      else
        rm -f $hosts
        return
      fi
    done
  fi
}

birdfirm_main
