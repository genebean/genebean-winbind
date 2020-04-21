Facter.add(:test_join) do
  setcode do
    kernel = Facter.value('kernel')

    case kernel
    ## linux case
    ##
    ## Note: the following are additional resources:
    ##
    ##       - https://linux.die.net/man/8/net
    ##       - http://linuxcommand.org/lc3_man_pages/typeh.html
    ##
    when 'Linux'
      # check AD is joined
      Facter::Core::Execution.exec('cd /home; type net &>/dev/null; net ads testjoin &>/dev/null 2>&1; echo $?')

    ## all other kernels
    else
      '1'
    end
  end
end
