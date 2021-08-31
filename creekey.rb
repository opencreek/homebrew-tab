class Creekey < Formula
  desc "Keep your private keys on your phone!"
  homepage "https://creekey.io"
  version "0.1.0-beta14"
  license ""

  bottle do
    root_url "https://github.com/opencreek/creekey-cli/releases/download/0.1.0-beta14"
    rebuild 1
    sha256 cellar: :any, big_sur: "c3fff158ab02b0d5238ecbcd331c69efa1041770070698cf9dfb8bc4ea5118ab"
    sha256 cellar: :any, catalina: "c85ffc7912c6513272f0de70915d44fa6d0a5bdd6b10cade24f4883d653b9f63"
  end

  url "https://github.com/opencreek/creekey-cli.git", tag: "0.1.0-beta14", revision: "25f70f2381fb11497f00a986d1878c61c0117216"

  head "https://github.com:opencreek/creekey-cli.git"

  depends_on "rust" => ":build"

  def install
    system "cargo", "install", *std_cargo_args

    bin.install "target/release/creekey"
    bin.install "target/release/creekey-git-sign"
  end

  plist_options :login => true
  def caveats
    "Run 'creekey pair' to pair with your phone!"
  end

  def plist; <<-EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>Label</key>
        <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
        <string>#{bin}/creekey</string>
        <string>agent</string>
      </array>
      <key>StandardOutPath</key>
      <string>/opt/homebrew/var/log/homebrew/creekey.log</string>
      <key>StandardErrorPath</key>
      <string>/opt/homebrew/var/log/homebrew/creekey.log</string>
      <key>KeepAlive</key>
      <true/>
    </dict>
    </plist>
  EOS
  end

  test do
    system "which", "creekey"
  end
end
