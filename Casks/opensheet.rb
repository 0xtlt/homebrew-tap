cask "opensheet" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.3.0"
  sha256 arm:   "bbbaf1f51e38f39273fd986f01ae95b1a98f0f945e9d7445892d862e41737447",
         intel: "846caa0b7c0d91d9dbf5f65ffec14086d1ce98583410547e709a3f87f993e362"

  url "https://github.com/0xtlt/opensheet/releases/download/v#{version}/opensheet-#{arch}-apple-darwin.dmg"
  name "OpenSheet"
  desc "Spreadsheet with the interface and behaviour of Excel"
  homepage "https://github.com/0xtlt/opensheet"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :monterey"

  app "OpenSheet.app"
  binary "#{appdir}/OpenSheet.app/Contents/MacOS/opensheet"

  zap trash: [
    "~/Library/Application Support/OpenSheet",
    "~/Library/Preferences/org.opensheet.OpenSheet.plist",
    "~/Library/Saved Application State/org.opensheet.OpenSheet.savedState",
  ]
end
