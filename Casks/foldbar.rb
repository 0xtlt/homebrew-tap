cask "foldbar" do
  arch arm: "arm64", intel: "x86_64"

  version "0.1.0"
  sha256 arm:   "ec6f149a11aeb7a21315e1bf10a86d137bb74798d2f8d5be0a332091e8a103e4",
         intel: "c21ecb1cdaa3e8522d0a47061c8cb8b1f51bc8169ac26a833a80340c98a26a3d"

  url "https://github.com/0xtlt/foldbar/releases/download/v#{version}/foldbar-#{arch}.dmg",
      verified: "github.com/0xtlt/foldbar/"
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
      FileUtils.rm_f("/tmp/foldbar-was-running")
    end
  end

  postflight do
    if File.exist?("/tmp/foldbar-was-running")
      FileUtils.rm_f("/tmp/foldbar-was-running")
      system "open", "#{appdir}/Foldbar.app"
    end
  end

  zap trash: "~/Library/Preferences/com.thomastastet.foldbar.plist"
end
