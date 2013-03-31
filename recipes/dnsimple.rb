include_recipe "dnsimple"
node.set[:generic_dns][:default_dns_provider] = :dnsimple
