cask "vitrail" do
  version "2.1.2"

  on_arm do
    url "https://github.com/0xtlt/vitrail/releases/download/v#{version}/Vitrail-arm64.dmg"
    sha256 "424a76e9d597c87bae7eeac118ec24d2ae5d211aee7b52120b59785b20025063"
  end

  on_intel do
    url "https://github.com/0xtlt/vitrail/releases/download/v#{version}/Vitrail-x86_64.dmg"
    sha256 "b7ee0c343fca7d59bb3e7cbfb87ff5c41c807ddf3d8ac267b3e82105d406a078"
  end

  name "Vitrail"
  desc "Lightweight macOS window layout manager with TOML config and global hotkeys"
  homepage "https://github.com/0xtlt/vitrail"

  app "Vitrail.app"

  postflight do
    system "open", "#{appdir}/Vitrail.app"
  end

  zap trash: [
    "~/.config/vitrail",
  ]
end
