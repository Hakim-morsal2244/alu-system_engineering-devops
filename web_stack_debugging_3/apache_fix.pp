# Install Apache if not already installed
package { 'apache2':
  ensure => 'installed',
}

# Ensure Apache is running
service { 'apache2':
  ensure => 'running',
  enable => true,
  subscribe => Package['apache2'],  # Restart Apache if package is changed
}

# Ensure the default web page (index.html) is in place
file { '/var/www/html/index.html':
  ensure  => 'file',
  content => '<html><body><h1>Apache is working!</h1></body></html>',
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0644',
  notify  => Service['apache2'],  # Restart Apache if the page content changes
}

# Ensure Apache is configured to serve the page correctly
file { '/etc/apache2/sites-available/000-default.conf':
  ensure  => 'file',
  content => '
<VirtualHost *:80>
    DocumentRoot /var/www/html
    <Directory /var/www/html>
        Options -Indexes +FollowSymLinks
        AllowOverride None
        Require all granted
    </Directory>
</VirtualHost>',
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  notify  => Service['apache2'],  # Restart Apache if config file changes
}
