class UpgradeEmacsSanity < Formula
  desc "Automatically upgrade Emacs packages in ~/.emacs-sanity"
  url "file:///dev/null"
  version "0.0.1"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  def install
    (libexec/"upgrade-emacs-sanity.el").write <<~EOS
      (package-upgrade-all)
    EOS

    (bin/"upgrade-emacs-sanity").write <<~EOS
      #!/bin/bash
      set -euo pipefail

      [ -d ~/.emacs-sanity ] || exit 1

      #{HOMEBREW_PREFIX}/bin/emacs                    \
          -nw                                         \
          --init-directory=~/.emacs-sanity            \
          --load ~/.emacs-sanity/init.el              \
          --script #{libexec}/upgrade-emacs-sanity.el
    EOS
  end

  service do
    run [opt_bin/"upgrade-emacs-sanity"]
    environment_variables PATH: std_service_path_env,
                          TERM: "xterm"
    log_path "/tmp/upgrade-emacs-sanity"
    error_log_path "/tmp/upgrade-emacs-sanity"
    run_type :interval
    interval 24*3600
  end
end
