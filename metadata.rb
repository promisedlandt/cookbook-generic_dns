name             "generic_dns"
maintainer       "Nils Landt"
maintainer_email "cookbooks@promisedlandt.de"
license          "MIT"
description      "Generic DNS LWRPs and DNS templates"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

%w(amazon_dns dnsimple).each { |dep| depends dep }

%w(ubuntu debian).each { |os| supports os }
