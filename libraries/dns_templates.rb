module GenericDns
  module DnsTemplates
    DNS_TEMPLATES = {
      "google_mail" => [
        { :values    => ["1 aspmx.l.google.com",
                         "5 alt1.aspmx.l.google.com",
                         "5 alt2.aspmx.l.google.com",
                         "10 aspmx2.googlemail.com",
                         "10 aspmx3.googlemail.com" ],
          :type      => "MX",
          :ttl       => 3600 },
        { :values => "\"v=spf1 include:_spf.google.com ~all\"",
          :type   => "TXT",
          :ttl    => 86400 }
      ]
    }.freeze

    def dns_template(template_name)
      DNS_TEMPLATES[template_name]
    end

    def dns_template_for_domain(template_name, domain_name)
      dns_template(template_name).collect do |record|
        record.merge(:fqdn => record[:subdomain] ? [record[:subdomain], domain_name].join(".") : domain_name)
      end
    end
  end
end
