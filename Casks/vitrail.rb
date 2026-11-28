cask "vitrail" do
  version "3.0.0"

  on_arm do
    url "https://github.com/0xtlt/vitrail/releases/download/v#{version}/Vitrail-arm64.dmg"
    sha256 "3aae8f8d44ca339fe66018e6bec50961afe4baa9dd3e020fd22d766e1afefe61"
  end

  on_intel do
    url "https://github.com/0xtlt/vitrail/releases/download/v#{version}/Vitrail-x86_64.dmg"
    sha256 "eb349fdeb0eab5187223ae0dd5be2983bf41f5482e3ee8e72a2dbfc8f2c1a195"
  end

  name "Vitrail"
  desc "Lightweight macOS window layout manager with TOML config and global hotkeys"
  homepage "https://github.com/0xtlt/vitrail"

  depends_on macos: ">= :sonoma"

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

