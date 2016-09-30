#!/bin/bash

birdfirm_main(){
  local birdfirm_root
  local root
  local hosts
  local hostfile
  local path
  birdfirm_root=$HOME/.birdfirm
  root=$birdfirm_root/hosts
  hosts=$root.txt

  trap birdfirm_hungup 1

  if [ -f $hosts ]; then
    echo "birdfirm locked. maybe running? (lock file : $hosts)"
    return
  fi

  if [ -d "$root" ]; then
    while [ true ]; do
      birdfirm_build_hosts
      hostfile=$(cat $hosts | peco)
      hostfile=${hostfile##* }
      if [ "$hostfile" ]; then
        path=$root/$hostfile
        if [ -f "$path" ]; then
          $path
        fi
      else
        birdfirm_cleanup
        return
      fi
    done
  fi
}
birdfirm_build_hosts(){
  ls -1 $root | awk '{print "  " $1}' > $hosts
  if [ "$(which tmux)" ]; then
    birdfirm_build_hosts_tmux
  fi
  if [ "$(which docker)" ]; then
    birdfirm_build_hosts_docker
  fi
}
birdfirm_build_hosts_tmux(){
  local socket
  local session
  for socket in $HOME/.tmux.wrapper/tmux-*.sock; do
    for session in $(tmux -S $socket ls -F '#S' 2> /dev/null); do
      sed "s/^  $session$/* $session/" -i $hosts
    done
  done
}
birdfirm_build_hosts_docker(){
  local session
  for session in $(docker ps --format "{{.Names}}"); do
    sed "s/^  $session$/* $session/" -i $hosts
  done
}
birdfirm_hungup(){
  birdfirm_cleanup
  exit 1
}
birdfirm_cleanup(){
  rm -f $hosts
}

birdfirm_main
