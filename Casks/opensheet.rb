cask "opensheet" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.2.1"
  sha256 arm:   "60fe6b6971e6d57e7e6f234045bf204633c2a53a0d0468a2a1ebde72813d2b3f",
         intel: "061e9240c653b16d22993f53dbe131eea22170273d15a9888d364c8f0285e4a1"

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
