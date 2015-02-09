module IpaInstallPlistGenerator
	class LinkGenerator
		def generate_install_link(install_plist_url)
			raise "https (secure HTTP) URL is required!" unless install_plist_url.start_with? 'https://'
			full_itms_install_url = "itms-services://?action=download-manifest&url=#{install_plist_url}"
			return full_itms_install_url
		end
	end
end