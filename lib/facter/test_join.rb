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
    # local variables
    cmd_cd = `cd ~`
    cmd_check_install = `#{cmd_cd} && type -p net > /dev/null 2>&1; echo $?`
    cmd_check_join = `net ads testjoin > /dev/null 2>&1; echo $?`
  
    # check if AD is joined
    if cmd_check_install
        if cmd_check_join
            "true"
        else
            "false"
        end
    else
        "false"
    end
  end

  ## windows case
  #
  #  Note: the following are addditional resources:
  #
  #        - https://technet.microsoft.com/en-us/library/bb490717.aspx
  confine :kernel => 'Windows'
  setcode do
    # local variables
    pattern = 'There are no entries in the list'
    cmd_cd = `cd .`
    cmd_check_join = `#{cmd_cd} && NET USE`

    # check if AD is joined
    if cmd_check_join.include? pattern
        "false"
    else
        "true"
    end
  end
end
