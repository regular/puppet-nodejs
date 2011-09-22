class nodejs::npm($user) {

  $NPM_INSTALL_DIR = '/tmp'

  exec { 'npm-install':
      command => 'curl http://npmjs.org/install.sh | clean=yes sh'
    , cwd     => $NPM_INSTALL_DIR
    , path    => ["/usr/bin/", "/bin"]
  }
    
}
