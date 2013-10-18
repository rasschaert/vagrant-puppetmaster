#!/bin/bash
# Do puppet agent runs until a run ends succesfully
RET=1
until [[ "$RET" -eq "0" ]]; do
  /usr/bin/puppet agent -t
  RET=$?
done
