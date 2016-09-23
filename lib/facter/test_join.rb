Facter.add(:test_join) do
  confine :kernel => 'Linux'
  setcode do
  
    # check if AD is joined
    Facter::Core::Execution.exec("system 'net',  'ads',  'testjoin'`")

  end
end
