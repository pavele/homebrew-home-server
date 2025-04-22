class NginxMiniStack < Formula
    desc     "Local nginx reverse‑proxy stack under ~/home-server"
    homepage "https://github.com/pavele/homebrew-home-server"
  
    # ── latest always: clone the repo itself ────────────────────────────────
    url     "https://github.com/pavele/homebrew-home-server.git",
            branch: "main",
            using:  :git
    version "latest"          # satisfies brew audit; not pinned
    license "MIT"
  
    depends_on "nginx"
  
    def install
      bin.install  "scripts/nginx-mini-setup"
      pkgshare.install Dir["files/*"]   # → $(brew --prefix)/share/nginx-mini-stack
    end
  end