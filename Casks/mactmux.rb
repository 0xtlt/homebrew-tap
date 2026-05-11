cask "mactmux" do
  arch arm: "arm64", intel: "x86_64"

  version "0.1.0-beta.1"
  sha256 arm:   "66a96a6cfaca0edd92724f64239275afd2e1c4b8587d6442656632821e7a93e4",
         intel: "38f096ef086211e11dc2d9487b20a78cb1ba0922fa8dc5bd0e7f0bc78ce28777"

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

  zap trash: "~/Library/Preferences/com.0xtlt.mactmux.plist"
end
