Facter.add(:test_join) do
  ## linux case
  #
  #  Note: the following are additional resources:
  #
  #        - https://linux.die.net/man/8/net
  #        - http://linuxcommand.org/lc3_man_pages/typeh.html
  #
  confine :kernel => 'Linux'
  setcode do
  
    # check if AD is joined: shell has been tested on unix systems
    Facter::Core::Execution.exec('if type -p net > /dev/null 2>&1; then if net ads testjoin; then echo "true"; else echo "false"; fi;  else echo "false"; fi')

  end

  ## windows case: https://technet.microsoft.com/en-us/library/bb490717.aspx
  confine :kernel => 'Windows'
  setcode do

    # check if AD is joined: shell has been tested in Windows 7
    #
    # Note: the 'exit(1)' is used to exit the awk if match found
    #
    Facter::Core::Execution.exec('NET USE | awk \'{if (/There are no entries in the list/) {print "false"; exit(1)};}\' && printf "true"')

  end
end
