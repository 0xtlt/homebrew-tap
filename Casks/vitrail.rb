cask "vitrail" do
  version "2.1.0"

  on_arm do
    url "https://github.com/0xtlt/vitrail/releases/download/v#{version}/Vitrail-arm64.dmg"
    sha256 "a39afcf3c66f9dc18a442dd011a50ea61efe5afd2344d71bd2e43db9fa24e599"
  end

  on_intel do
    url "https://github.com/0xtlt/vitrail/releases/download/v#{version}/Vitrail-x86_64.dmg"
    sha256 "c5616d73a6136a7e7814d77aec404205e051686d5b11343fd11605c604b3a366"
  end

  name "Vitrail"
  desc "Lightweight macOS window layout manager with TOML config and global hotkeys"
  homepage "https://github.com/0xtlt/vitrail"

  app "Vitrail.app"

  zap trash: [
    "~/.config/vitrail",
  ]
end
