#!/bin/bash

birdfirm_main(){
  local root
  local hostfile
  local socket
  local session
  local path
  root=$HOME/.birdfirm/hosts

  if [ -d "$root" ]; then
    while [ true ]; do
      ls -1 $root | awk '{print "  " $1}' > $root.txt
      for socket in $HOME/.tmux.wrapper/tmux-*.sock; do
        for session in $(tmux -S $socket ls -F '#S' 2> /dev/null); do
          sed "s/^  $session$/* $session/" -i $root.txt
        done
      done
      hostfile=$(cat $root.txt | peco)
      hostfile=${hostfile##* }
      if [ "$hostfile" ]; then
        path=$root/$hostfile
        if [ -f "$path" ]; then
          $path
        fi
      else
        return
      fi
    done
  fi
}

birdfirm_main
