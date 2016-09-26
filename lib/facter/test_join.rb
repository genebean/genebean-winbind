Facter.add(:test_join) do
  setcode do
    osfamily = Facter.value('osfamily')

    case osfamily
    ## linux case
    #
    #  Note: the following are additional resources:
    #
    #        - https://linux.die.net/man/8/net
    #        - http://linuxcommand.org/lc3_man_pages/typeh.html
    #
    when 'Linux'
      # local variables
      cmd_cd = `cd ~`
      cmd_check_install = `#{cmd_cd} && type -p net > /dev/null 2>&1; echo $?`
      cmd_check_join = `net ads testjoin > /dev/null 2>&1; echo $?`

      # check if AD is joined
      if cmd_check_install
        if cmd_check_join
          'true'
        else
          'false'
        end
      else
        'false'
      end
    ## windows case: tested on windows 7
    #
    #  Note: the following are addditional resources:
    #
    #        - https://technet.microsoft.com/en-us/library/bb490717.aspx
    when 'Windows'
      # local variables
      cmd_cd = `cd .`
      cmd_check_join = `#{cmd_cd} && NET USE`
      pattern = 'There are no entries in the list'

      # check if AD is joined
      if cmd_check_join.include? pattern
        'false'
      else
        'true'
      end
    ## else case: all other os families
    else
      'false'
    end

  end
end
