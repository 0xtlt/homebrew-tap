cask "tiler" do
  version "1.0.0"

  on_arm do
    url "https://github.com/0xtlt/tiler/releases/download/v#{version}/Tiler-arm64.dmg"
    sha256 "de90039a7e38221e62cb5b68ac067d7c76133890613d09254bdcdb890847c19c"
  end

  on_intel do
    url "https://github.com/0xtlt/tiler/releases/download/v#{version}/Tiler-x86_64.dmg"
    sha256 "ee41271c6ffaf0047d07bfd1c52668b063cb866358f30df4b6323b924b9b1d2c"
  end

  name "Tiler"
  desc "Lightweight macOS window layout manager with TOML config and global hotkeys"
  homepage "https://github.com/0xtlt/tiler"

  app "Tiler.app"

  zap trash: [
    "~/.config/tiler",
  ]
end
