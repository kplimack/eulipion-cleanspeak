# cleanspeak-cookbook
Installs and configures Inversoft's [Cleanspeak](http://www.inversoft.com/products/cleanspeak-profanity-filter-moderation-software).

## Supported Platforms

* Debian, Ubuntu

## Usage
Wrap it!
You'll need to set these attributes.
```
default[:cleanspeak][:config][:license_id] = 'YourKeyHere'
default[:cleanspeak][:database][:server][:host] = 'cleanspeak.database.rds.amazonaws.com'
default[:cleanspeak][:database][:server][:user] = 'cleanspeak_prod_user'
default[:cleanspeak][:database][:server][:name] = 'cleanspeak_prod_database_name'
```

## Optional Attributes
* change cleanspeak version
```
default[:cleanspeak][:version] = '2.3.2'
default[:cleanspeak][:source][:debian] = {
db_schema: {
url:
"http://www.inversoft.com/products/cleanspeak/#{node[:cleanspeak][:version]}/database/cleanspeak-database-schema-#{node[:cleanspeak][:version]}.zip",
checksum: 'b0b200'
},
realtime_filter_db: {
url:
"http://www.inversoft.com/products/cleanspeak/#{node[:cleanspeak][:version]}/database/cleanspeak-database-real-time-filter-#{node[:cleanspeak][:version]}.zip",
checksum: '089c8b'
},
languages_db: {
url:
"http://www.inversoft.com/products/cleanspeak/#{node[:cleanspeak][:version]}/database/cleanspeak-database-languages-#{node[:cleanspeak][:version]}.zip",
checksum: '4430d0'
},
mgmt_intf: {
url:
"http://www.inversoft.com/products/cleanspeak/#{node[:cleanspeak][:version]}/management-interface/cleanspeak-management-interface_#{node[:cleanspeak][:version]}-1_all.deb",
checksum: 'ee167be82a9b',
service: 'cleanspeak-management-interface'
},
webservice: {

url:"http://www.inversoft.com/products/cleanspeak/#{node[:cleanspeak][:version]}/webservice/cleanspeak-webservice_#{node[:cleanspeak][:version]}-1_all.deb",
checksum: '86a036',
service: 'cleanspeak-webservice'
},
searchengine: {
url:
"http://www.inversoft.com/products/cleanspeak/#{node[:cleanspeak][:version]}/search-engine/cleanspeak-search-engine_#{node[:cleanspeak][:version]}-1_all.deb",
checksum: 'dc079a96f920',
service: 'cleanspeak-search-engine'
}
}
```
* override which cookbook to use for database setup
`default[:cleanspeak][:database][:postgres][:cookbook] =  'myOrg-postgres'`

## License and Authors

Author:: Jake Plimack (<jake.plimack@gmail.com>)
