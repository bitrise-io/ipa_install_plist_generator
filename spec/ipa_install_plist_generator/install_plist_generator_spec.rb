require 'ipa_install_plist_generator/install_plist_generator'

describe IpaInstallPlistGenerator::PlistGenerator do

	describe '#generate_plist_string' do
		it "should raise an error if 'ipa_download_url' is not provided" do
			expect{
				ret_val = IpaInstallPlistGenerator::PlistGenerator.new.generate_plist_string(
					nil, nil, nil)
				}.to raise_error
		end
	end

end