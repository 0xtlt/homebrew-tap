cask "opensheet" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.2.2"
  sha256 arm:   "fe092b57fb73722d8cd1cc4b55fd1b585d4b4cdfb552de80c285574c917e630a",
         intel: "35a2463d1afdcb7d9ef456e3f4caff8245d869e5bdf17320f50c0a1fc551d4bb"

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
