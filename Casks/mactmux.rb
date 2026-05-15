cask "mactmux" do
  arch arm: "arm64", intel: "x86_64"

  version "0.1.0-beta.5"
  sha256 arm:   "c1160288c2db5088079bc06ee01488ea5962d70b824f9558534434b54eecab87",
         intel: "29b7be31177fb59161638edb1e615ab9de0cd1bb94b157abdd3c53a689ea5818"

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
