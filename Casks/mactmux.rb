cask "mactmux" do
  arch arm: "arm64", intel: "x86_64"

  version "0.1.0-beta.3"
  sha256 arm:   "3bc56eb2521e81c3c0d59f8479596cce2f6bc158389b5529bc135096712ca9bd",
         intel: "97b3d0ae62306bb02fd090b13f0337a7ce04e2e65409492e16fddfec2047d010"

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
