require 'ipa_install_plist_generator/install_link_generator'

describe IpaInstallPlistGenerator::LinkGenerator do

	describe '#generate_install_link' do
		it "should raise an error if the input link is not an HTTPS link" do
			plist_link = 'http://not-valid'
			expect{
				ret_val = IpaInstallPlistGenerator::LinkGenerator.new.generate_install_link(plist_link)
				}.to raise_error
		end

		it "should not raise an error if the input link is an HTTPS link" do
			plist_link = 'https://valid'
			ret_val = nil
			expect{
				ret_val = IpaInstallPlistGenerator::LinkGenerator.new.generate_install_link(plist_link)
				}.to_not raise_error
			expect(ret_val).to eq('itms-services://?action=download-manifest&url=https://valid')
		end
	end

end