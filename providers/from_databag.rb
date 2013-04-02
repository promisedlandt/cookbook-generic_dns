action :create_or_update do
  dns_provider = new_resource.dns_provider || node[:generic_dns][:default_dns_provider]

  if new_resource.credentials_data_bag_name && new_resource.credentials_data_bag_item
    credentials = Chef::EncryptedDataBagItem.load(new_resource.credentials_data_bag_name, new_resource.credentials_data_bag_item)
  else
    credentials = { "aws_access_key_id"     => new_resource.aws_access_key_id,
                    "aws_secret_access_key" => new_resource.aws_secret_access_key,
                    "login"                 => new_resource.dnsimple_username,
                    "password"              => new_resource.dnsimple_password }
  end

  unless (domains = data_bag(new_resource.dns_data_bag_name)).empty?
    domains.each do |domain_name|
      domain = data_bag_item(new_resource.dns_data_bag_name, domain_name)

      if domain["templates"]
        domain["templates"].each do |template|
          generic_dns_template template do
            dns_provider dns_provider
            domain domain["domain_name"]
            aws_access_key_id     credentials["aws_access_key_id"]
            aws_secret_access_key credentials["aws_secret_access_key"]
            dnsimple_username     credentials["login"]
            dnsimple_password     credentials["password"]
          end
        end
      end

      domain["records"].each do |domain_record|
        generic_dns_record domain_record["name"] do
          dns_provider dns_provider

          value  domain_record["content"]
          type   domain_record["type"]
          ttl    domain_record["ttl"]
          domain domain["domain_name"]

          aws_access_key_id     credentials["aws_access_key_id"]
          aws_secret_access_key credentials["aws_secret_access_key"]
          dnsimple_username     credentials["login"]
          dnsimple_password     credentials["password"]
        end
      end
    end
  end

end
