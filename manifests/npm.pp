class nodejs::npm($user) {

  $NPM_TMP_INSTALL_DIR = '/tmp'
  
  exec { 'wget-npm-install':
      command => 'wget http://npmjs.org/install.sh'
    , cwd     => $NPM_TMP_INSTALL_DIR
    , creates => "${NPM_TMP_INSTALL_DIR}/install.sh"
  }

  exec { 'npm-install':
      command => "clean=yes sh ${NPM_TMP_INSTALL_DIR}/install.sh"
    , path    => ["/bin"]
    , creates => '/usr/local/bin/npm'
    , require => Exec['wget-npm-install']
  }
    
}
