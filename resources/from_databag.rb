actions :create_or_update

default_action :create_or_update

attribute :dns_provider,              :equal_to => ["amazon", :amazon, "dnsimple", :dnsimple]
attribute :dns_data_bag_name,         :kind_of => String, :name_attribute => true
attribute :credentials_data_bag_name, :kind_of => String
attribute :credentials_data_bag_item, :kind_of => String
attribute :aws_access_key_id,         :kind_of => String
attribute :aws_secret_access_key,     :kind_of => String
attribute :dnsimple_username,         :kind_of => String
attribute :dnsimple_password,         :kind_of => String
