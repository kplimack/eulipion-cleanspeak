name             'eulipion-cleanspeak'
maintainer       'Jake Plimack'
maintainer_email 'jake.plimack@gmail.com'
license          'All rights reserved'
description      'Installs/Configures Inversoft\'s CleanSpeak'
long_description 'Installs/Configures Inversoft\'s CleanSpeak'
version          '0.1.1'

%w{ mysql postgresql tomcat test-helper database citadel java }.each { |dep| depends dep }

