class HomeServer < Formula
  desc "Local nginx reverse-proxy stack under ~/home-server"
  homepage "https://github.com/pavele/homebrew-home-server"
  url "https://github.com/pavele/homebrew-home-server/archive/refs/tags/v1.0.6.tar.gz"
  sha256 "d209731a23399c0fb03ce5322a7dd6981cd7ffdf14c97321ef1f045b107c3649"
  license "MIT"
  version "1.0.6"
  depends_on "nginx"

  def install
    bin.install "scripts/home-server-setup"
    pkgshare.install Dir["files/*"]
  end
end
