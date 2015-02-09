# IPA install Plist and link generator

Ruby GEM to generate a .plist which can be used for an IPA install.

This GEM can be used in your Ruby project directly or
you can install it and use it in your Command Line / Terminal.

You can use this GEM by adding it to your Gemfile:

    gem 'ipa_install_plist_generator', '~> 0.2.0'

Or install it as a system-wide GEM / CLI:

    gem install ipa_install_plist_generator

You can use this GEM as a CLI in two modes:

1. To generate a .plist file which you can save to your server to install an iOS app .ipa. Use the `ipa_plist_gen` command in your Command Line / Terminal.
2. Once you have an install .plist file and you uploaded it to your server (the URL have to be HTTPS, starting with iOS 8 a normal HTTP URL is not valid for app install!) you can generate an install link by providing the URL of the .plist file. You can then include this link in an email or on your website. A user (who's device is in the Provisioning Profile the .ipa was built with) can then open this special itms link to install the app (.ipa) on an iOS device. Use the `ipa_install_link_gen` command in your Command Line / Terminal.


## Generate the install .plist

To generate a .plist file you can call the gem from your Command Line / Terminal:

    $ ipa_plist_gen -i 'https://my-server/ipa-path.ipa' -b 'bundle.id' -t 'App Title'

This will print the .plist file to the standard output, you can redirect it to save it to a file or just copy-paste it into a .plist file.

At the moment a valid install .plist file have to contain the .ipa file's download url, a bundle ID and the app's title. You can define additional information if you want to.

Calling the `ipa_plist_gen` with every parameter looks like this:

    $ ipa_plist_gen -i 'https://my-server/ipa-path.ipa' -b 'bundle.id' -t 'App Title' --bundle-version '1.0.0' --display-image 'disp.img' --full-size-image 'full.img'

And it generated the .plist:

    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
        <key>items</key>
        <array>
            <dict>
                <key>assets</key>
                <array>
                    <dict>
                        <key>kind</key>
                        <string>software-package</string>
                        <key>url</key>
                        <string>https://my-server/ipa-path.ipa</string>
                    </dict>
                    <dict>
                        <key>kind</key>
                        <string>display-image</string>
                        <key>needs-shine</key>
                        <false/>
                        <key>url</key>
                        <string>disp.img</string>
                    </dict>
                    <dict>
                        <key>kind</key>
                        <string>full-size-image</string>
                        <key>needs-shine</key>
                        <false/>
                        <key>url</key>
                        <string>full.img</string>
                    </dict>
                </array>
                <key>metadata</key>
                <dict>
                    <key>bundle-identifier</key>
                    <string>bundle.id</string>
                    <key>bundle-version</key>
                    <string>1.0.0</string>
                    <key>kind</key>
                    <string>software</string>
                    <key>title</key>
                    <string>App Title</string>
                </dict>
            </dict>
        </array>
    </dict>
    </plist>


## Generate an install link for the .plist file

Once you uploaded this .plist file to your server you can generate the special `itms-services` link in the Command Line / Terminal:

    $ ipa_install_link_gen -l 'https://my-server/install.plist'
