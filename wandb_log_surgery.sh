#!/bin/bash

cd "$CONDA_PREFIX"
lib="$(find . -maxdepth 4 -name "wandb" -type d)"

if [ ! -d "$lib" ]; then
    echo "wandb not found in $CONDA_PREFIX"
    exit 1
fi

lib="$(readlink -f "$lib")"
cd "$lib"

vim -u NONE sdk/wandb_run.py +'
g/def _footer.*status/exe "norm f(%jV/def\<cr>{c        pass\eo"
' +wq

vim -u NONE sdk/internal/file_pusher.py +'
g/def print_status/exe "norm f(%jV/def\<cr>{c        pass\eo"
' +wq

echo "modified $lib/sdk/wandb_run.py and $lib/sdk/internal/file_pusher.py"
 
