cask "mactmux" do
  arch arm: "arm64", intel: "x86_64"

  version "0.1.0-beta.4"
  sha256 arm:   "42894b451bf5d6f27128f65f3db9f352c6f979d0b83efd300b477ffbd5f1ad66",
         intel: "b84f1707c60418cfee4bbda7c2bd0c589591d7beac4b588b5a50cab0c81ca719"

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
