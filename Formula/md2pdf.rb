class Md2pdf < Formula
  desc "Fast, standalone Markdown to PDF converter written in Rust"
  homepage "https://github.com/0xtlt/md2pdf"
  version "3.4.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/0xtlt/md2pdf/releases/download/v#{version}/md2pdf-macos-arm64.tar.gz"
      sha256 "47ac1a0e753222135f6522e8b7645c0a03f88b561320f4a431c481ba6c3a184b"
    end
    on_intel do
      url "https://github.com/0xtlt/md2pdf/releases/download/v#{version}/md2pdf-macos-x86_64.tar.gz"
      sha256 "5913c3248c15f6db6f3223e113efc7120d9d0553c4d4b4438ec00427fcbcab5c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/0xtlt/md2pdf/releases/download/v#{version}/md2pdf-linux-x86_64.tar.gz"
      sha256 "1e7390c4cbe73f2145f33e75c018f720cd6df2149d35c7a84d6d3019f4d4bcb7"
    end
  end

  def install
    binary = Dir["*/md2pdf", "md2pdf"].find { |path| File.file?(path) }
    odie "expected md2pdf binary in release archive" unless binary
    bin.install binary => "md2pdf"
  end

  def caveats
    <<~EOS
      This is the Rust md2pdf from 0xtlt/md2pdf.

      Homebrew core ships a different Go-based md2pdf (solworktech/md2pdf).
      Always install this formula with the fully-qualified name:

        brew install 0xtlt/tap/md2pdf

      If `md2pdf --help` mentions md2pdf.go or only -i/-o flags, uninstall the
      core package first, then reinstall from this tap.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/md2pdf --version")
  end
end
