
# postgresql or mysql
default[:cleanspeak][:database][:server] = {
  type: 'postgresql',
  host: 'localhost' # if set to localhost, will include the `server` recipe, otherwise will use a remote host
}
default[:cleanspeak][:database][:mysql] = {
  cookbook: 'mysql'
}
default[:cleanspeak][:database][:postgresql] = {
  cookbook: 'showmobile-postgresql'
}
