cask "foldbar" do
  arch arm: "arm64", intel: "x86_64"

  version "0.1.2"
  sha256 arm:   "2cf1725f33539a8fa91c458ea2a0635ac23b7a2c69b68d5cbffaece0dc2cedd3",
         intel: "d79e524d8534e92295a0fc0f21ec86aa5cd1f03bf72ee8150ee738d889f51db4"

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
