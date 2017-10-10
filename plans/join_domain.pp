# This plan runs the puppet agent to ensure all the settings needed for joining
# a domain have been put in place, joins a domin, and reruns puppet.
plan winbind::join_domain (
  String[1] $domainuser,
  String[1] $domainpassword,
  Variant[String[1], Array[String[1]]] $nodes,
) {
  $puppet_command = 'puppet agent -t'
  run_command($puppet_command, $nodes)
  run_task('winbind::run_join_domain', $nodes, {domainuser => $domainuser, domainpassword => $domainpassword})
  run_command($puppet_command, $nodes)
}
