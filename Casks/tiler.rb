cask "tiler" do
  version "1.1.0"

  on_arm do
    url "https://github.com/0xtlt/tiler/releases/download/v#{version}/Tiler-arm64.dmg"
    sha256 "b050b12d86c1c8f9b67cc2462e7434c54cd51423d15be7035ec8b014765a8369"
  end

  on_intel do
    url "https://github.com/0xtlt/tiler/releases/download/v#{version}/Tiler-x86_64.dmg"
    sha256 "fd292b121a56985da58aa1f88f9510660f275d21479f9958dd6017f998e9831a"
  end

  name "Tiler"
  desc "Lightweight macOS window layout manager with TOML config and global hotkeys"
  homepage "https://github.com/0xtlt/tiler"

  app "Tiler.app"

  zap trash: [
    "~/.config/tiler",
  ]
end
