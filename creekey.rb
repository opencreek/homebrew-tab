class Creekey < Formula
  desc "Keep your private keys on your phone!"
  homepage "https://creekey.io"
  version "0.1.1"
  license ""

  bottle do
    root_url "https://github.com/opencreek/creekey-cli/releases/download/0.1.1"
    rebuild 1
    sha256 cellar: :any, big_sur: "e34b688e79c6e53f14398256aa4b455709ff454c737e5ac17d20cfe954dd5326"
    sha256 cellar: :any, catalina: "64405812c80f46ae914316d13e3ec05fee4f5f3f95b73a03d2591c624b4fa1eb"
  end

  url "https://github.com/opencreek/creekey-cli.git", tag: "0.1.1", revision: "d407506b90e2f8a0640b5d80e6b9df103c523b85"

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
