Facter.add(:test_join) do
  setcode do
    kernel = Facter.value('kernel')

    case kernel
    ## linux case
    #
    #  Note: the following are additional resources:
    #
    #        - https://linux.die.net/man/8/net
    #        - http://linuxcommand.org/lc3_man_pages/typeh.html
    #
    when 'Linux'
      Facter::Core::Execution.exec('cd /home; type net &>/dev/null; net ads testjoin &>/dev/null 2>&1; echo $?')

    ## windows case
    #
    #  Note: the following are addditional resources:
    #
    #        - https://technet.microsoft.com/en-us/library/bb490717.aspx
    #
    when 'Windows'
      # local variables
      cmd_check_join = `cd /home; NET USE`
      pattern = 'There are no entries in the list'

      # check if AD is joined
      if cmd_check_join.include? pattern
        '0'
      else
        '1'
      end

    ## else case: all other os families
    else
      '1'
    end

  end
end
