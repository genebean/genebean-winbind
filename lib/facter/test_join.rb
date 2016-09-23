Facter.add(:test_join) do
  confine :osfamily => 'RedHat'
  setcode do
  
    # check if AD is joined
    Facter::Core::Execution.exec("system 'net',  'ads',  'testjoin'`")

  end
end
