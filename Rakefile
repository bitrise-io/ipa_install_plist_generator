require "bundler/setup"

gemspec = eval(File.read("ipa_install_plist_generator.gemspec"))

task :build => "#{gemspec.full_name}.gem"

file "#{gemspec.full_name}.gem" => gemspec.files + ["ipa_install_plist_generator.gemspec"] do
  system "gem build ipa_install_plist_generator.gemspec"
end
