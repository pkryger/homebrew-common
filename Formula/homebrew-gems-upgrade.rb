class HomebrewGemsUpgrade < Formula
  desc "Automatically upgrade Homebrew Gems to run sorbet"
  url "file:///dev/null"
  version "0.0.1"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  depends_on "direnv"

  def install
    (bin/"homebrew-gems-upgrade").write <<~EOS
      #!/bin/bash
      set -euo pipefail

      envrc_file=$(brew --prefix)/Library/.envrc
      if [[ -f "${envrc_file}" ]]; then
          direnv exec "$(brew --prefix)/Library" bundle update --bundler"
          direnv exec "$(brew --prefix)/Library" bundle install --gemfile "$(brew --prefix)/Library/Homebrew/Gemfile"
      else
          >&2 echo "Missing ${envrc_file} - install from https://github.com/pkryger/dotfiles"
      fi
    EOS
  end

  def caveats
    <<~EOS
      This script relies on existence of #{HOMEBREW_PREFIX}/Library/.envrc.
      Install it from https://github.com/pkryger/dotfiles.
    EOS
  end

  service do
    run [opt_bin/"homebrew-gems-upgrade"]
    environment_variables PATH:            std_service_path_env,
                          TERM:            "xterm",
                          HOMEBREW_PREFIX: HOMEBREW_PREFIX
    log_path "/tmp/homebrew-gems-upgrade"
    error_log_path "/tmp/homebrew-gems-upgrade"
    run_type :interval
    interval 86400
  end
end
