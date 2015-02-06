require 'optparse'
require 'plist'


# -------------------------
# --- Options

options = {
	is_verbose: false,
	#
	install_plist_url: nil,
	#
	ipa_download_url: nil,
	bundle_identifier: nil,
	app_title: nil,
	bundle_version: nil
}

# meta:
#  * bundle-identifier
#  * kind: software
#  * title
# - optional: bundle-version

opt_parser = OptionParser.new do |opt|
	opt.banner = "Usage: ipa_install_plist_generator.rb [OPTIONS]"
	opt.separator  ""
	opt.separator  "Options, the ones marked with * are required"

	opt.on("-l","--link LINK_URL", "*Plist download URL. If this option is specified then no Plist generation will happen, instead it will print an install-url (to the Plist's URL you provide) which can be opened on an iOS device to install the app (itms-services://?action=download-manifest&url=https://path/to/app.plist).") do |value|
		options[:install_plist_url] = value
	end

	opt.on("-i","--ipa IPA_DOWNLOAD_URL", "*IPA download url") do |value|
		options[:ipa_download_url] = value
	end

	opt.on("-b", "--bundle-identifier BUNDLE_ID", "*Metadata: Bundle ID") do |value|
		options[:bundle_identifier] = value
	end

	opt.on("-t", "--app-title APP_TITLE", "*Metadata: App Title") do |value|
		options[:app_title] = value
	end

	opt.on("--bundle-version BUNDLE_VERSION", "Metadata: Bundle Version") do |value|
		options[:bundle_version] = value
	end

	opt.on("-v","--verbose","Verbose output") do
		options[:is_verbose] = true
	end

	opt.on("-h","--help","Shows this help message") do
		puts opt_parser
		exit 0
	end
end

opt_parser.parse!
$options = options


# -------------------------
# --- Utils

def vputs(msg="")
	if $options[:is_verbose]
		puts msg
	end
end


# -------------------------
# --- Main

vputs "options: #{options}"

if options[:install_plist_url]
	inst_url = options[:install_plist_url]
	raise "https (secure HTTP) URL is required!" unless inst_url.start_with? 'https://'
	full_itms_install_url = "itms-services://?action=download-manifest&url=#{inst_url}"
	puts full_itms_install_url
	exit 0
end

raise "No IPA download URL specified" unless options[:ipa_download_url]
raise "No Bundle Identifier specified" unless options[:bundle_identifier]
raise "No App Title specified" unless options[:app_title]

exit_code = 0


# - meta
meta_item = {
	'kind' => 'software',
	'bundle-identifier' => options[:bundle_identifier],
	'title' => options[:app_title]
}
if options[:bundle_version]
	meta_item['bundle-version'] = options[:bundle_version]
end

# - main download/asset content
asset_items = []

asset_items << {
	kind: 'software-package',
	url: options[:ipa_download_url]
}

# - create the Plist
plist_content_item = {
	assets: asset_items,
	metadata: meta_item
}

plist_hash = {
	items: [plist_content_item]
}

puts Plist::Emit.dump(plist_hash)

exit exit_code
