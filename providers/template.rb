include GenericDns::DnsTemplates

action :create_or_update do

  dns_template_for_domain(new_resource.template_name, new_resource.domain).each do |record|
    generic_dns_record record[:fqdn] do
      domain            new_resource.domain
      ttl               record[:ttl]
      type              record[:type]
      value             record[:values]
      dns_provider      new_resource.dns_provider
      aws_access_key_id new_resource.aws_access_key_id if new_resource.aws_access_key_id
      aws_secret_access_key new_resource.aws_secret_access_key if new_resource.aws_secret_access_key
      dnsimple_username new_resource.dnsimple_username if new_resource.dnsimple_username
      dnsimple_password new_resource.dnsimple_password if new_resource.dnsimple_password
    end
  end

end
