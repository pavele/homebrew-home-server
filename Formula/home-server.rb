class HomeServer < Formula
  desc "Local nginx reverse-proxy stack under ~/home-server"
  homepage "https://github.com/pavele/homebrew-home-server"
  url "https://github.com/pavele/homebrew-home-server/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "abc123..."
  license "MIT"

  depends_on "nginx"

  def install
    bin.install "scripts/home-server-setup"
    pkgshare.install Dir["files/*"]
  end
end
