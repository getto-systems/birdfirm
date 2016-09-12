#!/bin/bash

birdfirm_main(){
  local root
  local hostfile
  local session
  local path
  root=$HOME/.birdfirm/hosts

  if [ -d "$root" ]; then
    while [ true ]; do
      ls -1 $root | awk '{print "  " $1}' > $root.txt
      for session in $(tmux -S $HOME/.tmux.wrapper/tmux.sock ls -F '#S' 2> /dev/null); do
        sed "s/^  $session$/* $session/" -i $root.txt
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
