#!/bin/bash
# Do puppet agent runs until a run ends succesfully
RET=1
PATH="/usr/bin:/opt/ruby/bin:$PATH" # Possible locations of the puppet binary
until [[ "$RET" -eq "0" ]]; do
  puppet agent -t
  RET=$?
done
