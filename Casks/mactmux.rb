cask "mactmux" do
  arch arm: "arm64", intel: "x86_64"

  version "0.1.0-beta.2"
  sha256 arm:   "aa868e6677cca1953724454c3f8d5a42787c75f205d12428ee3c5404af9f9786",
         intel: "972a6e3f90b0c69be314d6f40c0c8bb2a3bc4c0688ea9e4c643b23e6615a2b00"

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
