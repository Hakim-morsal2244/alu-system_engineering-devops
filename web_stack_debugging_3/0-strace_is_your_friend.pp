# Puppet manifest to ensure Apache is installed and running
exec { 'install_apache':
  command => '/usr/bin/apt-get install -y apache2',
  path    => ['/bin', '/usr/bin'],
  onlyif  => 'test ! -x /usr/sbin/apache2',
}

service { 'apache2':
  ensure  => running,
  enable  => true,
  require => Exec['install_apache'],
}
