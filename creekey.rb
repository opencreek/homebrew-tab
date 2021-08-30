class Creekey < Formula
  desc "Keep your private keys on your phone!"
  homepage "https://creekey.io"
  version "0.1.0-beta11"
  license ""

  url "https://github.com/opencreek/creekey-cli.git", tag: "0.1.0-beta11", revision: "917cdda637c3d03d84e43884907b64a82365289e"

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
