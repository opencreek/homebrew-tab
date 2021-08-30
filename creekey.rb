class Creekey < Formula
  desc "Keep your private keys on your phone!"
  homepage "https://creekey.io"
  version "0.1.0-beta12"
  license ""

  bottle do
    root_url "https://github.com/opencreek/creekey-cli/releases/download/0.1.0-beta12"
    rebuild 1
    sha256 cellar: :any, big_sur: "6808a183f6489d219fb557c8a14659a50db8f4a16ee5a3e1f2b535a4e254a1a7"
    sha256 cellar: :any, catalina: "2cbfd35c563e7645649d56fd6b15eba1cc6b72e118ed3edeb2346852f47f41c8"
  end

  url "https://github.com/opencreek/creekey-cli.git", tag: "0.1.0-beta12", revision: "79fc7979960d14088f936f1dd60246e19bc68026"

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
