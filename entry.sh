#!/bin/bash
cd /home/jovyan/de
cp /home/jovyan/* /home/jovyan/de -r
pwd
ls -lah
exec xonsh main.xsh $1 $2