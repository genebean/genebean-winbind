Facter.add(:test_winbind) do
  setcode do
    osfamily = Facter.value('osfamily')

    case osfamily
    ## linux case
    #
    #  Note: the following are additional resources:
    #
    #        - http://linuxcommand.org/man_pages/wbinfo1.html
    #        - https://www.samba.org/samba/docs/man/manpages/wbinfo.1.html
    #
    when "Linux"
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
        end
      else
        'false'
      end
    ## windows case: samba doesn't run on windows
    when 'Windows'
      Facter::Core::Execution.exec('echo "false"')
    ## else case: all other os families
    else
      'false'
    end

  end
end
