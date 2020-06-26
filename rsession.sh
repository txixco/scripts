#!/bin/bash

tmux has-session -t $1
if [ $? != 0 ]
then
    tmux new -s $1 -n dunning-letters -c Codigo/UiPath/finance---dunning-letters -d
    tmux split-window -h -c Codigo/UiPath/application-libraries
    tmux select-pane -t {left}
 
#    tmux new-window -n library -c Codigo/UiPath/application-libraries
#    tmux new-window -n man "man tmux"

    tmux select-window -t $1:dunning-letters
fi

tmux attach -t $1

