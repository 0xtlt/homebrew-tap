cask "mactmux" do
  arch arm: "arm64", intel: "x86_64"

  version "0.1.0-beta.9"
  sha256 arm:   "72425e6765991bbe2bc07b3ad744c7028682909eff2a4685a3abc2725ef251da",
         intel: "dca440aab0f53f4f2a0f8ff19e04be941a5956d3900df77b732518736b1f7ea9"

  url "https://github.com/0xtlt/MacTMUX/releases/download/v#{version}/mactmux-#{arch}.dmg"
  name "MacTMUX"
  desc "Menu bar utility for tmux sessions"
  homepage "https://github.com/0xtlt/MacTMUX"

  depends_on macos: ">= :sonoma"

  app "MacTMUX.app"

  preflight do
    was_running = system("/usr/bin/pgrep", "-xq", "MacTMUX")
    if was_running
      File.write("/tmp/mactmux-was-running", "1")
      system("/usr/bin/pkill", "-x", "MacTMUX")
      sleep 1
    else
      FileUtils.rm("/tmp/mactmux-was-running", force: true)
    end
  end

  postflight do
    if File.exist?("/tmp/mactmux-was-running")
      FileUtils.rm("/tmp/mactmux-was-running", force: true)
      system "open", "#{appdir}/MacTMUX.app"
    end
  end

  zap trash: [
    "~/Library/LaunchAgents/com.0xtlt.mactmux.loginitem.plist",
    "~/Library/Preferences/com.0xtlt.mactmux.plist",
  ]
end
