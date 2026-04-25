cask "foldbar" do
  arch arm: "arm64", intel: "x86_64"

  version "0.1.1"
  sha256 arm:   "48bb295aba340e4b977bc70f61949dabc0c18c4903f4eaae4db63b24c4b91e4b",
         intel: "66fe97b0d17d2cd6059a98411e50c0b541a98ea4a00759f4fe65628e0c3a7936"

  url "https://github.com/0xtlt/foldbar/releases/download/v#{version}/foldbar-#{arch}.dmg"
  name "Foldbar"
  desc "Menu bar utility to fold away menu bar icons"
  homepage "https://github.com/0xtlt/foldbar"

  depends_on macos: ">= :sequoia"

  app "Foldbar.app"

  preflight do
    was_running = system("/usr/bin/pgrep", "-xq", "foldbar")
    if was_running
      File.write("/tmp/foldbar-was-running", "1")
      system("/usr/bin/pkill", "-x", "foldbar")
      sleep 1
    else
      FileUtils.rm("/tmp/foldbar-was-running", force: true)
    end
  end

  postflight do
    if File.exist?("/tmp/foldbar-was-running")
      FileUtils.rm("/tmp/foldbar-was-running", force: true)
      system "open", "#{appdir}/Foldbar.app"
    end
  end

  zap trash: "~/Library/Preferences/com.thomastastet.foldbar.plist"
end
