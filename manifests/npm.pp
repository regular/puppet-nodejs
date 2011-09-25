class nodejs::npm($user) {

  $NPM_PATH = '/usr/local/src/npm'
  $NPM_REPO = 'git://github.com/isaacs/npm.git'

  package { "nodejs::npm-build-essential-dep":
      name    => 'build-essential'
    , ensure  => 'installed'
  }
  
  package { "npm-git-dep":
      name    => 'git'
    , ensure  => "installed"
  }
  
  exec { 'npm-git-clone':
      command => "git clone ${NPM_REPO} ${NPM_PATH}"
    , path    => ['/usr/bin']
    , creates => "${NPM_PATH}/.git/HEAD"
  }
  
  exec { "make_npm":
    cwd     => $NPM_PATH,
    command => "make install",
    require => [Exec['npm-git-clone'], Package['nodejs::npm-build-essential-dep']],
    creates => "/usr/local/bin/npm",
    timeout => 0,
    path    => ["/usr/bin/","/bin/", "/usr/local/bin"],
  }
    
}