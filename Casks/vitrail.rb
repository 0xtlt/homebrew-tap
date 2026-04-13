cask "vitrail" do
  version "2.2.3"

  on_arm do
    url "https://github.com/0xtlt/vitrail/releases/download/v#{version}/Vitrail-arm64.dmg"
    sha256 "fea045f17bc7c818327aef1f0517c514a653b3d401a0930aea1f6ac4fd39fe1d"
  end

  on_intel do
    url "https://github.com/0xtlt/vitrail/releases/download/v#{version}/Vitrail-x86_64.dmg"
    sha256 "09cd81c8954b4b1413ac65d66c440463b742cfc80a6b6212061e8ea259c629b4"
  end

  name "Vitrail"
  desc "Lightweight macOS window layout manager with TOML config and global hotkeys"
  homepage "https://github.com/0xtlt/vitrail"

  app "Vitrail.app"

  preflight do
    was_running = system("/usr/bin/pgrep", "-xq", "Vitrail")
    if was_running
      File.write("/tmp/vitrail-was-running", "1")
      system("/usr/bin/pkill", "-x", "Vitrail")
      sleep 1
    else
      File.delete("/tmp/vitrail-was-running") if File.exist?("/tmp/vitrail-was-running")
    end
  end

  postflight do
    if File.exist?("/tmp/vitrail-was-running")
      File.delete("/tmp/vitrail-was-running")
      system "open", "#{appdir}/Vitrail.app"
    end
  end

  zap trash: [
    "~/.config/vitrail",
  ]
end
