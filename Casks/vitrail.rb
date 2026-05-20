cask "vitrail" do
  version "2.3.0"

  on_arm do
    url "https://github.com/0xtlt/vitrail/releases/download/v#{version}/Vitrail-arm64.dmg"
    sha256 "0a28cee33c069b0d71870533331e80f1b863f8fb1227e9e287e81ab224691dff"
  end

  on_intel do
    url "https://github.com/0xtlt/vitrail/releases/download/v#{version}/Vitrail-x86_64.dmg"
    sha256 "081d7cbb313a9dda538d2a20c3a9a27e53cdbcaa9be4a41c58b37485ddabf23d"
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
