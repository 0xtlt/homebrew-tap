cask "vitrail" do
  version "2.2.0"

  on_arm do
    url "https://github.com/0xtlt/vitrail/releases/download/v#{version}/Vitrail-arm64.dmg"
    sha256 "d4841a7c0c9f2e4683f8e878a49337b909e8efa5e56244f38741861d4a335563"
  end

  on_intel do
    url "https://github.com/0xtlt/vitrail/releases/download/v#{version}/Vitrail-x86_64.dmg"
    sha256 "3c5a6964ccdd9664c9fc2cc1e6174358721d03d3d9fd595faf814ad3c219b9da"
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
