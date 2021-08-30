class Creekey < Formula
  desc "Keep your private keys on your phone!"
  homepage "https://creekey.io"
  version "0.1.0-beta7"
  license ""

  bottle do
    root_url "https://github.com/opencreek/creekey-cli/releases/download/0.1.0-beta7"
    rebuild 1
    sha256 cellar: :any, big_sur: "d1ff99a9f8b01f87b2a03e30a9a783d0b8364f4179f5f1878036fb850b2ba1e4"
    sha256 cellar: :any, catalina: "66cf0af6953e1eb13efb5dc48c2daea1cdc9239f0e875bd06e8d7a918d2ff22e"
  end

  url "https://github.com/opencreek/creekey-cli.git", tag: "0.1.0-beta7", revision: "1d3ae5ecb4018b6fb05623c65a8532f58112bf38"

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
