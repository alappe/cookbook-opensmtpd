name             'opensmtpd'
maintainer       'kaeufli.ch'
maintainer_email 'nd@kaeufli.ch'
license          'MIT'
description      'Installs/Configures opensmtpd'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

recipe "opensmtpd", "Installs OpenSMTPD from source"

# Depend of
depends 'git'

# Supported OS
%w{ ubuntu debian }.each do |os|
  supports os
end
