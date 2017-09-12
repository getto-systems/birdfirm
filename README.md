# birdfirm

select executables and execute it


## Usage

```
./path/to/birdfirm
```

### Setup

#### simple bin files

```bash
# ~/.birdfirm/bin/some_executable
#!/bin/bash
echo hello, birdfirm
```

#### use birdfirm_cage

```bash
# ~/.birdfirm/tmux_to_local

tmux new -s $1
```

```bash
tmux_to_local=$HOME/.birdfirm/tmux_to_local

# <command> <arg> <arg> ...
birdfirm_cage $tmux_to_local getto-blog
birdfirm_cage $tmux_to_local getto-css
birdfirm_cage $tmux_to_local getto-base
```


## Requirements

[junegunn/fzf : GitHub](https://github.com/junegunn/fzf)
