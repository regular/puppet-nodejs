class nodejs::npm($user) {

  $npm_path = "/opt/npm-src"

  package { "npm-git-dep":
    ensure => "installed"
  }
  
  vcsrepo { $npm_path:
    ensure  => present,
    provider => git,
    source => "http://github.com/isaacs/npm.git",
    require => [Exec["install_node"], Package["npm-git-dep"]], 
    revision => "HEAD"
  }

  
  exec { "make_npm":
    cwd => "$npm_path",
    command => "make install",
    require => Vcsrepo[$npm_path],
    creates => "/usr/local/bin/npm",
    timeout => 0,
    path    => ["/usr/bin/","/bin/", "/opt/node/bin"],
  }
    
}