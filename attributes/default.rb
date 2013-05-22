default['opensmtpd'] = {
  'git_url' => 'git://github.com/poolpOrg/OpenSMTPD.git',
  'git_rev' => 'portable',
  'src_dir' => '/usr/local/src/opensmtpd',
  'prefix' => '/usr/local',
  'config_dir' => '/etc',
  'privsep' => {
    'empty_dir' => '/var/empty',
    'user_shell' => '/usr/sbin/nologin'
  },
  'smtpd.conf' => {
    'macros' => {
    },
    'listen' => [
      'on localhost'
    ],
    'accept' => [
      'for local alias <aliases> deliver to mbox '
    ],
    'reject' => [
    ],
    'bounce-warn' => '4h',
    'expire' => '4d',
    'max-message-size' => nil,
    'tables' => {
      'aliases' => {
        'path' => '/etc/aliases',
        'type' => 'db',
        'content' => {
          'postmaster' => 'root'
        }
      },
    }
  }
}
