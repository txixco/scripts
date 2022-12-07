#!/bin/bash

tmux has-session -t $1
if [ $? != 0 ]
then
    tmux new -s $1 -n Code -c Code/UIPath -d cmatrix
    tmux split-window -h -c Code/UIPath -p 90
    tmux split-window -v -c Code/UIPath/application-libraries
 
    tmux select-pane -t 2
fi

tmux attach -t $1

