cask "vitrail" do
  version "2.2.2"

  on_arm do
    url "https://github.com/0xtlt/vitrail/releases/download/v#{version}/Vitrail-arm64.dmg"
    sha256 "fd9e9bdce0cbc2999b2d0c1e431da15ca4a4211c36207ea2ecca97c77fac4856"
  end

  on_intel do
    url "https://github.com/0xtlt/vitrail/releases/download/v#{version}/Vitrail-x86_64.dmg"
    sha256 "942f954a9b670684d593ea3b125debd940d9355394c010a4727b24d8207bf72d"
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
