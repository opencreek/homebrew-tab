class Creekey < Formula
  desc "Keep your private keys on your phone!"
  homepage "https://creekey.io"
  version "v0.3.0"
  license ""

  url "https://github.com/opencreek/creekey-cli.git", tag: "v0.3.0", revision: "325bf5f86da8aff0ea431efcfb35e3585a566756"

  head "https://github.com:opencreek/creekey-cli.git"

  depends_on "rust" => ":build"

  def install
    system "cargo", "install", *std_cargo_args

    bin.install "target/release/creekey"
    bin.install "target/release/creekey-git-sign"
  end

  service do
    run [opt_bin/"creekey", "agent"]
    keep_alive true
  end
  
  def caveats
    "Run 'creekey pair' to pair with your phone!"
  end

  test do
    system "which", "creekey"
  end
end
