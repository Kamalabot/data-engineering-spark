#!/bin/bash

if [ ! -e /opt/.initialized ]
then
  sudo touch /opt/.initialized
#  sudo chown -R itversity:itversity /home/itversity/itversity-material
fi

/home/minion01/.local/bin/jupyter lab --ip 0.0.0.0
