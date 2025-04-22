class HomeServer < Formula
  desc     "Local nginx reverse‑proxy stack under ~/home-server"
  homepage "https://github.com/pavele/homebrew-home-server"

  # always install latest commit on main
  url     "https://github.com/pavele/homebrew-home-server.git",
          branch: "main",
          using:  :git
  version "latest"
  license "MIT"

  depends_on "nginx"

  def install
    bin.install  "scripts/home-server-setup"
    pkgshare.install Dir["files/*"]   # → $(brew --prefix)/share/home-server
  end
end