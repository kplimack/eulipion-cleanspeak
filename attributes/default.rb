include_attribute 'java'
default['java']['jdk_version'] = '7'
default['java']['install_flavor'] = 'oracle'
default['java']['jdk']['7']['x86_64']['url'] = 'http://download.oracle.com/otn-pub/java/jdk/7u75-b13/jdk-7u75-linux-x64.tar.gz'
default['java']['oracle']['accept_oracle_download_terms'] = true

default[:cleanspeak][:version] = '3.0.1'
default[:cleanspeak][:install] = {
  path: '/data/www/cleanspeak',
  cookbooks: %w{ java }
}
default[:cleanspeak][:database][:server] = {
  type: 'postgres',
  host: 'localhost', # if set to localhost, will include the `server` recipe, otherwise will use a remote host
  auth: 'citadel',
  citadel_path: "apps/cleanspeak_#{node.chef_environment}.json",
  name: 'cleanspeak'
}
default[:cleanspeak][:config] = {
  license_id: nil,
  path: '/usr/local/inversoft',
  tomcat: {
    'cleanspeak-management-interface.management-port' => '8010',
    'cleanspeak-management-interface.http-port' => '8011',
    'cleanspeak-management-interface.https-port' => '8013',
    'cleanspeak-search-engine.transport-port' => '8020',
    'cleanspeak-search-engine.http-port' => '8021',
    'cleanspeak-webservice.management-port' => '8000',
    'cleanspeak-webservice.http-port' => '8001',
    'cleanspeak-webservice.https-port' => '8003',

    'cleanspeak-management-interface.memory' => '1G',
    'cleanspeak-search-engine.memory' => '1G',
    'cleanspeak-webservice.memory' => '1G'
  }
}
default[:cleanspeak][:database][:mysql] = {
  cookbook: 'mysql',
  port: '3306'
}
default[:cleanspeak][:database][:postgres] = {
  cookbook: 'postgresql',
  port: '5432'
}

default[:cleanspeak][:email] = {
  host: 'localhost',
  port: '25',
  ssl: false,
  username: nil,
  password: nil,
  email_from: "cleanspeak@#{node.name}"
}

default[:cleanspeak][:source][:debian] = {
  db_schema: {
    url: "http://www.inversoft.com/products/cleanspeak/#{node[:cleanspeak][:version]}/database/cleanspeak-database-schema-#{node[:cleanspeak][:version]}.zip",
    checksum: 'b0b200'
#    notifies: "create_database_#{node[:cleanspeak][:database][:server][:type]}"
  },
  realtime_filter_db: {
    url: "http://www.inversoft.com/products/cleanspeak/#{node[:cleanspeak][:version]}/database/cleanspeak-database-real-time-filter-#{node[:cleanspeak][:version]}.zip",
    checksum: '089c8b'
  },
  languages_db: {
    url: "http://www.inversoft.com/products/cleanspeak/#{node[:cleanspeak][:version]}/database/cleanspeak-database-languages-#{node[:cleanspeak][:version]}.zip",
    checksum: '4430d0'
  },
  mgmt_intf: {
    url: "http://www.inversoft.com/products/cleanspeak/#{node[:cleanspeak][:version]}/management-interface/cleanspeak-management-interface_#{node[:cleanspeak][:version]}-1_all.deb",
    checksum: 'ee167be82a9b',
    service: 'cleanspeak-management-interface'
  },
  webservice: {
    url:"http://www.inversoft.com/products/cleanspeak/#{node[:cleanspeak][:version]}/webservice/cleanspeak-webservice_#{node[:cleanspeak][:version]}-1_all.deb",
    checksum: '86a036',
    service: 'cleanspeak-webservice'
  },
  searchengine: {
    url: "http://www.inversoft.com/products/cleanspeak/#{node[:cleanspeak][:version]}/search-engine/cleanspeak-search-engine_#{node[:cleanspeak][:version]}-1_all.deb",
    checksum: 'dc079a96f920',
    service: 'cleanspeak-search-engine'
  }
}




