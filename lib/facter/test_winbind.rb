Facter.add(:test_winbind) do
  setcode do
    kernel = Facter.value('kernel')

    case kernel
    ## linux case
    #
    #  Note: the following are additional resources:
    #
    #        - http://linuxcommand.org/man_pages/wbinfo1.html
    #        - https://www.samba.org/samba/docs/man/manpages/wbinfo.1.html
    #
    when "Linux"
      Facter::Core::Execution.exec('cd /home; type wbinfo &>/dev/null; winbind -p &>/dev/null; echo $?')

    ## windows case: samba doesn't run on windows
    when 'Windows'
      Facter::Core::Execution.exec('echo "false"')

    ## else case: all other os families
    else
      '1'
    end

  end
end
