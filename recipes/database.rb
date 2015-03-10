
case node[:cleanspeak][:database][:server][:auth]
when 'citadel'
  conf = JSON.parse(citadel('show-chef')[node[:cleanspeak][:database][:server][:citadel_path]])
  username = conf['username']
  password = conf['password']
end

case node[:cleanspeak][:database][:server][:type]
when 'postgres'
  db_provider = Chef::Provider::Database::Postgresql
  user_provider = Chef::Provider::Database::PostgresqlUser
when 'mysql'
  db_provider = Chef::Provider::Database::Mysql
  user_provider = Chef::Provider::Database::MysqlUser
end

db_connection = {
  host: node[:cleanspeak][:database][:server][:host],
  port: node[:cleanspeak][:database][:server][:port] || '5432',
  username: node[:cleanspeak][:database][:server][:user] || 'postgres'
  password: node[:postgresql][:password][:postgres]
}

database node[:cleanspeak][:database][:server][:name] do
  connection db_connection
  provider db_provider
  action :create
  only_if { node[:cleanspeak][:database][:server][:host] == 'localhost' }
end
case node[:cleanspeak][:database][:server][:type]
when 'postgres'
  # RDS already has a user created, just do this for local setups
  postgresql_database_user username do
    connection db_connection
    provider user_provider
    action :create
    password password
    only_if { node[:cleanspeak][:database][:server][:host] == 'localhost' }
  end
when 'mysql'
  mysql_database_user username do
    connection db_connection
    provider user_provider
    action :create
    password password
  end
end

if node[:cleanspeak][:database][:server][:type] == 'postgres'
  postgresql_database 'vacuum databases' do
    connection db_connection
    database_name node[:cleanspeak][:database][:server][:name]
    sql 'VACUUM FULL VERBOSE ANALYZE'
    action :query
  end
end
