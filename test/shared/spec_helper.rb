require 'serverspec'
set :backend, :exec

set :path, '/sbin:/usr/sbin:/usr/local/sbin:$PATH'

$node = ::JSON.parse(File.read('/tmp/serverspec/node.json'))
