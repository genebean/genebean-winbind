Facter.add(:test_join) do
  ## linux case
  #
  #  Note: the following are additional resources:
  #
  #        - http://linuxcommand.org/man_pages/wbinfo1.html
  #        - https://www.samba.org/samba/docs/man/manpages/wbinfo.1.html
  #
  confine :kernel => 'Linux'
  setcode do
  
    # query winbind: check winbind is alive
    Facter::Core::Execution.exec('if type -p wbinfo > /dev/null 2>&1; then if wbinfo -p > /dev/null 2>&1; then echo "true"; else echo "false"; fi;  else echo "false"; fi')

  end

  ## windows case: samba doesn't run on windows
  confine :kernel => 'Windows'
  setcode do

    Facter::Core::Execution.exec('echo "false"')

  end
end
