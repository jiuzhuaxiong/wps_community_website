#!/usr/bin/env ruby

require 'cgi'
require 'yaml'
require 'zlib'
require 'template/overall.rb'
require 'libraries/dirs.rb'

def get_ref_name q
  Zlib::crc32(q).to_s 16
end

def html_faq
  faqs = YAML.load_file DATA_DIR + "/faqs.yaml"
  faqs.collect do |faq|
    ref_name = get_ref_name faq["Q"]
    "<a name=\"#{ref_name}\"></a>
    <b>Q: #{faq["Q"]}</b> <a href='\##{ref_name}'>ref</a><br/>
    A: #{faq["A"]}<br/><br/>"
  end.join "\n"
end

cont = <<EOF
#{html_header "FAQ"}
<div class="body">
<h1>FAQ</h1>
#{html_faq}
</div>
Cannot find what you need? <a href="/forum">Try forum here</a>.
<br/>
#{html_tail}
EOF

cgi = CGI.new
cgi.out {
  cont
}
