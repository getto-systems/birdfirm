#!/bin/bash

birdfirm_main(){
  local root
  local hostfile
  local path
  root=$HOME/.birdfirm

  if [ -d "$root" ]; then
    hostfile=$(ls -1 $root | peco)
    if [ "$hostfile" ]; then
      path=$root/$hostfile
      if [ -f "$path" ]; then
        $path
      fi
    fi
  fi
}

birdfirm_main
