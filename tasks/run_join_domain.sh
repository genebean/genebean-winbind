#!/bin/bash

# Puppet Task Name: run_join_domain
#
# This is where you put the shell code for your task.
#
# This task assumes that you have created /root/joinDomain.sh on the target
# nodes and that it has been configured to get the username and password
# for joining the domain from environment variables. The variables your script
# will need to look for are:
# PT_username - the username of a user who can join a machine to the domain
# PT_password - the password for the user being used to join the domain
#
 if [ -z "$PT_domainuser" ]; then
   echo "The PT_username environment variable is missing"
   exit 1
 elif [ -z "$PT_domainpassword" ]; then
   echo "The PT_password environment variable is missing"
   exit 1
fi

/root/joinDomain.sh
