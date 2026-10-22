cask "foldbar" do
  arch arm: "arm64", intel: "x86_64"

  version "0.1.3"
  sha256 arm:   "fd9dc0a8d715701dd3538f812b178d5abc0d2f502861035daaa26009600ec6bd",
         intel: "567947a08c6b3bb5bf69ebd113db2f4ab28b3102f170b4f13802a14bafb192a2"

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
