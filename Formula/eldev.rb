class Eldev < Formula
  desc "Elisp development tool"
  homepage "https://emacs-eldev.github.io/eldev"

  head do
    url "https://github.com/emacs-eldev/eldev.git", branch: "master"
  end

  def install
    bin.install("bin/eldev")
  end

end
