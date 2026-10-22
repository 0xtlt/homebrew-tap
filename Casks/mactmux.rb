cask "mactmux" do
  version "0.1.0-beta.10"
  sha256 "945ebc94ab4bbe680ea79b877200ea3055eaaf997577284984e736981b4ad821"

  url "https://github.com/0xtlt/MacTMUX/releases/download/v#{version}/mactmux-arm64.dmg"
  name "MacTMUX"
  desc "Menu bar utility for tmux sessions"
  homepage "https://github.com/0xtlt/MacTMUX"

  depends_on arch: :arm64
  depends_on macos: ">= :tahoe"

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
