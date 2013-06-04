name             'opensmtpd'
maintainer       'kaeufli.ch'
maintainer_email 'nd@kaeufli.ch'
license          'MIT'
description      'Installs/Configures opensmtpd'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.0'

recipe "opensmtpd", "Installs OpenSMTPD from source"
supports "ubuntu"
depends "git"
