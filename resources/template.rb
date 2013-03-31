actions :create_or_update

default_action :create_or_update

attribute :dns_provider,          :kind_of => [String, Symbol]
attribute :template_name,         :equal_to => [:google_mail, "google_mail"], :name_attribute => true
attribute :domain,                :required => true
attribute :aws_access_key_id,     :kind_of => String
attribute :aws_secret_access_key, :kind_of => String
attribute :dnsimple_username,     :kind_of => String
attribute :dnsimple_password,     :kind_of => String
