Facter.add(:test_join) do
  ## linux case: https://linux.die.net/man/8/net
  confine :kernel => 'Linux'
  setcode do
  
    # check if AD is joined
    Facter::Core::Execution.exec('net ads testjoin')

  end

  ## windows case: https://technet.microsoft.com/en-us/library/bb490717.aspx
  confine :kernel => 'Windows'
  setcode do

    # check if AD is joined
    Facter::Core::Execution.exec('NET USE | %errorlevel%')

  end
end
