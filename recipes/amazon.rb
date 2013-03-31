include_recipe "amazon_dns"
node.set[:generic_dns][:default_dns_provider] = :amazon
