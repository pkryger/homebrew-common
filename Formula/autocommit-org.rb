class AutocommitOrg < Formula
  desc "Automatically Commit and push changes in directory ~/org"
  url "file:///dev/null"
  version "0.0.1"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  def install
    (bin/"autocommit-org").write <<~EOS
      #!/bin/bash
      set -euo pipefail

      cd ~/org
      git pull
      git add -A
      git commit -m "[automatic commit]" || exit 0
      git push
    EOS
  end

  service do
    run [opt_bin/"autocommit-org"]
    environment_variables PATH: std_service_path_env,
                          TERM: "xterm"
    log_path "/tmp/autocommit-org.sleep"
    error_log_path "/tmp/autocommit-org.sleep"
    run_type :interval
    interval 3600
  end
end
