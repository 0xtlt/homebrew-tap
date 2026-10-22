cask "opensheet" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.2.3"
  sha256 arm:   "98c6f522dd0f7d09f5969e98009306b39a7ccc7dd57e1f24fb9099b29a1121c6",
         intel: "ba0681833357dac581bca33c26bdbeab72e60bd419a8475babbed33ed7feba18"

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
