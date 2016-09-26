Facter.add(:test_winbind) do
  ## linux case
  #
  #  Note: the following are additional resources:
  #
  #        - http://linuxcommand.org/man_pages/wbinfo1.html
  #        - https://www.samba.org/samba/docs/man/manpages/wbinfo.1.html
  #
  confine :kernel => 'Linux'
  setcode do
    # local variables
    cmd_cd = `cd ~`
    cmd_check_install = `#{cmd_cd} && type -p wbinfo > /dev/null 2>&1; echo $?`
    cmd_ping_winbind = `wbinfo -p > /dev/null 2>&1; echo $?`

    # query winbind: check winbind is alive
    if cmd_check_install
        if cmd_ping_winbind
            'true'
        else
            'false'
    else
        'false'
    end
  end

  ## windows case: samba doesn't run on windows
  confine :kernel => 'Windows'
  setcode do

    Facter::Core::Execution.exec('echo "false"')

  end
end
