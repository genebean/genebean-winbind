Facter.add(:test_winbind) do
  setcode do
    kernel = Facter.value('kernel')

    case kernel
    ## linux case
    ##
    ## Note: the following are additional resources:
    ##
    ##       - http://linuxcommand.org/man_pages/wbinfo1.html
    ##       - https://www.samba.org/samba/docs/man/manpages/wbinfo.1.html
    ##
    when 'Linux'
      # check winbind is alive
      Facter::Core::Execution.exec('cd /home; type wbinfo &>/dev/null; wbinfo -P &>/dev/null 2>&1; echo $?')

    ## all other kernels
    else
      '1'
    end
  end
end
