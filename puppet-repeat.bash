#!/bin/bash
COUNTER=0
RET=1
until [[ "$RET" -eq "0" ]]; do
  let COUNTER=COUNTER+1 
  echo "#########################################"
  echo "## STARTING PUPPET RUN NUMBER $COUNTER ##"
  echo "#########################################"
  /usr/bin/puppet agent -t
  RET=$?
done
