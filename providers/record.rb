action :create_or_update do
  dns_provider = new_resource.dns_provider ? new_resource.dns_provider : node[:generic_dns][:default_dns_provider]

  case dns_provider.to_sym
  when :amazon
    amazon_dns_zone new_resource.domain do
      aws_access_key_id     new_resource.aws_access_key_id if new_resource.aws_access_key_id
      aws_secret_access_key new_resource.aws_secret_access_key if new_resource.aws_secret_access_key

      action :create
    end

    amazon_dns_record new_resource.name do
      domain                new_resource.domain if new_resource.domain
      zone_id               new_resource.zone_id if new_resource.zone_id
      value                 new_resource.value if new_resource.value
      alias_target          new_resource.alias_target if new_resource.alias_target
      type                  new_resource.type
      ttl                   new_resource.ttl
      weight                new_resource.weight if new_resource.weight
      aws_access_key_id     new_resource.aws_access_key_id if new_resource.aws_access_key_id
      aws_secret_access_key new_resource.aws_secret_access_key if new_resource.aws_secret_access_key

      action :create_or_update
    end

  when :dnsimple
    dnsimple_record new_resource.name do
      type     new_resource.type
      ttl      new_resource.ttl
      domain   new_resource.domain
      content  new_resource.value
      username new_resource.dnsimple_username ? new_resource.dnsimple_username : node[:dnsimple][:username]
      password new_resource.dnsimple_password ? new_resource.dnsimple_password : node[:dnsimple][:password]

      action :create
    end

  else
    Chef::Log.fatal "No DNS provider set for #{ new_resource.name }, I don't know what to do"
  end

end

action :destroy do
  dns_provider = new_resource.dns_provider ? new_resource.dns_provider : node[:generic_dns][:default_dns_provider]

  case dns_provider.to_sym
  when :amazon
    amazon_dns_record new_resource.name do
      action :destroy
    end
  when :dnsimple
    dnsimple_record new_resource.name do
      action :destroy
    end
  else
    Chef::Log.fatal "No DNS provider set for #{ new_resource.name }, I don't know what to do"
  end
end
