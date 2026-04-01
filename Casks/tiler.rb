cask "tiler" do
  version "1.0.0"

  on_arm do
    url "https://github.com/0xtlt/tiler/releases/download/v#{version}/Tiler-arm64.dmg"
    sha256 "aa67135dd264b1ecc99a4e10902dfc6c87d34081d4fa6cfeffdec7490eb8c2e6"
  end

  on_intel do
    url "https://github.com/0xtlt/tiler/releases/download/v#{version}/Tiler-x86_64.dmg"
    sha256 "bfa1409352d45505426d9e792337283dd3b424800c8542fd1084454e34e56408"
  end

  name "Tiler"
  desc "Lightweight macOS window layout manager with TOML config and global hotkeys"
  homepage "https://github.com/0xtlt/tiler"

  app "Tiler.app"

  zap trash: [
    "~/.config/tiler",
  ]
end
