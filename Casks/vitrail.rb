cask "vitrail" do
  version "2.0.0"

  on_arm do
    url "https://github.com/0xtlt/vitrail/releases/download/v#{version}/Vitrail-arm64.dmg"
    sha256 "6c8ace9ca39b7831c2a6f54433ebbcb5daf8b347812b1f6f327bf54042ac9d11"
  end

  on_intel do
    url "https://github.com/0xtlt/vitrail/releases/download/v#{version}/Vitrail-x86_64.dmg"
    sha256 "1992025fd7cd36edc418ce700e1db7f936c9c04b8018e5da6165e23f59745431"
  end

  name "Vitrail"
  desc "Lightweight macOS window layout manager with TOML config and global hotkeys"
  homepage "https://github.com/0xtlt/vitrail"

  app "Vitrail.app"

  zap trash: [
    "~/.config/vitrail",
  ]
end
