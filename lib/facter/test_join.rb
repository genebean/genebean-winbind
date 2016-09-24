Facter.add(:test_join) do
  ## linux case: https://linux.die.net/man/8/net
  confine :kernel => 'Linux'
  setcode do
  
    # check if AD is joined
    Facter::Core::Execution.exec('if type net; then if net ads testjoin; then echo "true"; else echo "false"; fi;  else echo "false"; fi')

  end

  ## windows case: https://technet.microsoft.com/en-us/library/bb490717.aspx
  confine :kernel => 'Windows'
  setcode do

    # check if AD is joined
    Facter::Core::Execution.exec('NET USE')

  end
end
