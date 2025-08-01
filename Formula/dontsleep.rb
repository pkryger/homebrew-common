class Dontsleep < Formula
  desc "Prevent computer from sleeping when lid is open"
  url "file:///dev/null"
  version "0.0.1"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  def install
    (bin/"dontsleep").write <<~EOS
      #!/bin/bash

      cmd="caffeinate -dist 86400"

      ps aux | grep -e "\\d ${cmd}$" | grep -v grep || ${cmd}
    EOS
  end

  service do
    run [opt_bin/"dontsleep"]
    environment_variables PATH: std_service_path_env,
                          TERM: "xterm"
    log_path "/tmp/dont-sleep"
    error_log_path "/tmp/dont-sleep"
    run_type :interval
    interval 300
  end
end
