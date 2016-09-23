Facter.add(:test_join) do
  confine :kernel => 'Linux'
  setcode do
  
    # check if AD is joined
    Facter::Core::Execution.exec("system 'net',  'ads',  'testjoin'")

  end

  confine :kernel => 'Windows'
  setcode do

    # check if AD is joined
    Facter::Core::Execution.exec("system 'NET',  'USE',  '|', '%errorlevel%'")

  end
end
