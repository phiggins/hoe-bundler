class Hoe #:nodoc:
  #
  #  Rake task to generate a bundler Gemfile based on your declared hoe dependencies.
  #
  #  * <tt>bundler:gemfile</tt>
  #
  module Bundler
    VERSION = "1.0.0" #:nodoc:

    def define_bundler_tasks
      desc "generate a bundler Gemfile from your Hoe.spec dependencies"
      task "bundler:gemfile" do
        File.open("Gemfile","w") do |gemfile|
          gemfile.puts "# -*- ruby -*-"
          gemfile.puts
          gemfile.puts "source :gemcutter"
          gemfile.puts
          self.extra_deps.each do |name, version|
            gemfile.puts %Q{gem "#{name}", "#{version.gsub(/ /,'')}"}
          end
          gemfile.puts
          self.extra_dev_deps.each do |name, version|
            gemfile.puts %Q{gem "#{name}", "#{version.gsub(/ /,'')}", :group => [:development, :test]}
          end
          gemfile.puts
          gemfile.puts "# vim: syntax=ruby"
        end
      end
    end
  end
end
