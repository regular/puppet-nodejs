class nodejs::npm($user) {

  $NPM_TMP_INSTALL_DIR = '/tmp'
  
  exec { 'wget-npm-install':
      command => 'wget http://npmjs.org/install.sh'
    , cwd     => $NPM_TMP_INSTALL_DIR
    , creates => "${NPM_TMP_INSTALL_DIR}/install.sh"
    , path    => ['/usr/bin']
  }

  exec { 'npm-install':
      command => "sh ${NPM_TMP_INSTALL_DIR}/install.sh"
    , cwd     => $NPM_TMP_INSTALL_DIR
    , path    => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin']
    , creates => '/usr/local/bin/npm'
    , require => Exec['wget-npm-install', ]
  }
    
}
