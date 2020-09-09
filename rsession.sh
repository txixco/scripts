#!/bin/bash

tmux has-session -t $1
if [ $? != 0 ]
then
    tmux new -s $1 -n dunning-letters -c Code/UIPath/finance---dunning-letters -d
    tmux split-window -h -c Code/UIPath/application-libraries
    tmux select-pane -t {left}
 
    tmux select-window -t $1:dunning-letters
fi

tmux attach -t $1

