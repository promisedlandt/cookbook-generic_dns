# generic_dns

Provides a LWRPs to manage DNS records, using Amazon Route 53 or DNSimple.

Also provides DNS templates for commonly used services, such as Google Mail.

# Platforms

Tested on Ubuntu 12.04 and Debian 6.0.6.

# Requirements

Chef 11

# Examples

```
node.set[:generic_dns][:default_dns_provider] = :amazon

# Add subdomain1 to example.com using Route 53
generic_dns_record "subdomain1" do
  value "192.168.1.1"
  domain "example.com"
  aws_access_key_id     "ASDASDASDASD"
  aws_secret_access_key "GSDFGSDFDFGF"
end

# Let's add a CNAME record using DNSimple
generic_dns_record "mail" do
  value "ghs.google.com"
  domain "example.com"
  type "CNAME"
  ttl 86400
  aws_access_key_id     "ASDASDASDASD"
  aws_secret_access_key "GSDFGSDFDFGF"
end

# Apply the google mail template to add MX records and a TXT spf record
generic_dns_template "google_mail" do
  domain "example.com"
  aws_access_key_id     "ASDASDASDASD"
  aws_secret_access_key "GSDFGSDFDFGF"
end
```

# Authentication

You can either provide authentication via resource attributes (see generic_dns_record attributes), or as node attributes.  
For node attributes, use `node[:dnsimple][:username]` and `node[:dnsimple][:password]` or `node[:amazon_dns][:aws_access_key_id]` and `node[:amazon_dns][:aws_secret_access_key]`.

# Templates

Templates are simply a number of predefined DNS records.  
For example, the google_mail template will add an MX record with the 5 gmail servers and their priorities, as well as a TXT record used in SPF.

The following templates are available:

Template | Description
---------|------------
google_mail | Set up [Google Mail](https://mail.google.com/)

# Recipes

## generic_dns::default

Installs prequisites for either the [amazon_dns](https://github.com/promisedlandt/cookbook-amazon_dns) or [dnsimple](https://github.com/aetrion/chef-dnsimple) cookbook.

# Attributes

## default

Attribute | Description | Type | Default
----------|-------------|------|--------
default_dns_provider | The dns provider you want to use, amazon or dnsimple | String, Symbol | :amazon

# Resources / Providers

## generic_dns_record

Creates a record using either DNSimple or Amazon Route 53.  
If using Amazon, creates a zone as needed.

### Attributes

Attribute | Description | Type | Default
----------|-------------|------|--------
dns_provider | Which DNS provider to use, overrides node attribute | String, Symbol | 
name | Name of the dns entry, can be "subdomain" or "subdomain.example.com" | String | name
domain | Name of the domain to add the entry to (set this or zone_id) | String |
value | Value for the DNS record. Not needed for Amazon alias records | String, Array | 
type | DNS record type | String | A
ttl | Time to live | Integer, String | 3600
weight | For weighted record sets. Amazon only | Integer, String |
zone_id | Zone_id of the zone to add the entry to (set this or domain). Amazon only | String |
alias_target | Targets for alias records. Hash that needs they keys `:dns_name` and `:hosted_zone_id`. Amazon only | Hash
aws_access_key_id | Your AWS access key ID. Amazon only | String
aws_secret_access_key | Your AWS secret access key. Amazon only | String
dnsimple_username | Username for your DNSimple account. DNSimple only | String
dnsimple_password | Password for your DNSimple account. DNSimple only | String

### Actions

Name | Description | Default
-----|-------------|--------
create_or_update | Create or update the record | yes

## generic_dns_template

Creates DNS records from predefined templates

### Attributes

Attribute | Description | Type | Default
----------|-------------|------|--------
dns_provider | Which DNS provider to use, overrides node attribute | String, Symbol | 
template_name | Name of the template to apply | String | name
domain | Name of the domain to add the entry to | String |
aws_access_key_id | Your AWS access key ID. Amazon only | String
aws_secret_access_key | Your AWS secret access key. Amazon only | String
dnsimple_username | Username for your DNSimple account. DNSimple only | String
dnsimple_password | Password for your DNSimple account. DNSimple only | String


### Actions

Name | Description | Default
-----|-------------|--------
create_or_update | Create or update the record | yes

