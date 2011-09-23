class nodejs::npm($user) {

  $NPM_TMP_PATH = "/tmp/npm"

  package { "npm-git-dep":
      name    => 'git'
    , ensure  => "installed"
  }
  
  exec { 'npm-git-clone':
      command => "git clone ${NPM_REPO} ${NPM_TMP_PATH}"
    , path    => ['/usr/bin']
  }
  
  exec { "make_npm":
    cwd => $NPM_TMP_PATH,
    command => "make install",
    require => Exec['npm-git-clone'],
    creates => "/usr/local/bin/npm",
    timeout => 0,
    path    => ["/usr/bin/","/bin/", "/opt/node/bin"],
  }
    
}