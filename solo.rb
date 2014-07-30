cb1 = File.expand_path "../site-cookbooks", __FILE__
cb2 = File.expand_path "../cookbooks", __FILE__

cookbook_path [cb1, cb2]
json_attribs "node-data.json"
ssl_verify_mode :verify_peer
