require 'plist'

module IpaInstallPlistGenerator
	class PlistGenerator
		def generate_plist_string(ipa_download_url, bundle_identifier, app_title,
			bundle_version=nil, display_image=nil, full_size_image=nil)

			raise "No IPA download URL specified" unless ipa_download_url
			raise "No Bundle Identifier specified" unless bundle_identifier
			raise "No App Title specified" unless app_title

			# - meta
			meta_item = {
				'kind' => 'software',
				'bundle-identifier' => bundle_identifier,
				'title' => app_title
			}
			if bundle_version
				meta_item['bundle-version'] = bundle_version
			end

			# - main download/asset content
			asset_items = []

			asset_items << {
				kind: 'software-package',
				url: ipa_download_url
			}
			if display_image
				asset_items << {
					'kind' => 'display-image',
					'needs-shine' => false,
					'url' => display_image
				}
			end
			if full_size_image
				asset_items << {
					'kind' => 'full-size-image',
					'needs-shine' => false,
					'url' => full_size_image
				}
			end

			# - create the Plist
			plist_content_item = {
				assets: asset_items,
				metadata: meta_item
			}

			plist_hash = {
				items: [plist_content_item]
			}

			return Plist::Emit.dump(plist_hash)
		end
	end
end