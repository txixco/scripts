#!/bin/bash

tmux has-session -t $1
if [ $? != 0 ]
then
    tmux new -s $1 -n Code -c Code/actual -d cmatrix -a
    tmux split-window -h -c Code/actual -p 90
    tmux split-window -v -c Code/actual/application-libraries
 
    tmux select-pane -t 2
fi

tmux attach -t $1

