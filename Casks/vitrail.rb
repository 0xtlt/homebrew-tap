cask "vitrail" do
  version "2.1.2"

  on_arm do
    url "https://github.com/0xtlt/vitrail/releases/download/v#{version}/Vitrail-arm64.dmg"
    sha256 "424a76e9d597c87bae7eeac118ec24d2ae5d211aee7b52120b59785b20025063"
  end

  on_intel do
    url "https://github.com/0xtlt/vitrail/releases/download/v#{version}/Vitrail-x86_64.dmg"
    sha256 "b7ee0c343fca7d59bb3e7cbfb87ff5c41c807ddf3d8ac267b3e82105d406a078"
  end

  name "Vitrail"
  desc "Lightweight macOS window layout manager with TOML config and global hotkeys"
  homepage "https://github.com/0xtlt/vitrail"

  app "Vitrail.app"

  preflight do
    system_command "/usr/bin/pgrep", args: ["-xq", "Vitrail"],
                   print_stderr: false, must_succeed: false
    if $CHILD_STATUS.success?
      File.write("/tmp/vitrail-was-running", "1")
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
