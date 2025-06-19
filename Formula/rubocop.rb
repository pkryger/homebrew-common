class Rubocop < Formula
  desc "Ruby static code analyzer (a.k.a. linter) and code formatter"
  homepage "https://github.com/rubocop/rubocop"
  license "MIT License"
  head "https://github.com/rubocop/rubocop.git",
    branch: "master"

  depends_on "ruby"

  def install
    ENV["GEM_HOME"] = libexec
    system Formula["ruby"].opt_bin/"gem", "build", "rubocop.gemspec"
    require "#{buildpath}/lib/rubocop/version"
    system Formula["ruby"].opt_bin/"gem", "install", "rubocop-#{RuboCop::Version::STRING}.gem"
    bin.install libexec/"bin/rubocop"
    bin.env_script_all_files(libexec/"bin", GEM_HOME: ENV["GEM_HOME"])
  end

  test do
    system bin/"rubocop", "--version"
  end
end
