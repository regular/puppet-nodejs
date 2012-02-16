class nodejs::npm($user) {

  $NPM_PATH = '/usr/local/src/npm'
  $NPM_REPO = 'git://github.com/isaacs/npm.git'
  $NPM_VERSION = 'v1.0.106'
  
  package { "npm-git-dep":
      name    => 'git'
    , ensure  => "installed"
  }
  
  exec { 'npm-git-clone':
      command => "git clone ${NPM_REPO} ${NPM_PATH}"
    , path    => ['/usr/bin']
    , creates => "${NPM_PATH}/.git/HEAD"
  }

  exec { 'npm-git-checkout':
      command => "git checkout ${NPM_VERSION}"
    , require => Exec['npm-git-clone']
    , cwd     => $NPM_PATH
    , path    => ['/usr/bin']
  }

  exec { "make_npm":
      cwd     => $NPM_PATH
    , command => "make install"
    , require => [Exec['npm-git-checkout'], Package['build-essential']]
    , creates => "/usr/local/bin/npm"
    , timeout => 0
    , path    => ["/usr/bin/","/bin/", "/usr/local/bin"]
  }
    
}