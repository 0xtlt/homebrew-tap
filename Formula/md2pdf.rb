class Md2pdf < Formula
  desc "Fast, standalone Markdown to PDF converter written in Rust"
  homepage "https://github.com/0xtlt/md2pdf"
  version "3.4.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/0xtlt/md2pdf/releases/download/v#{version}/md2pdf-macos-arm64.tar.gz"
      sha256 "687281b98d7a3c0f8da938e9d965d09acbd9e6f8de4756bdfc9b7da1ee180303"
    end
    on_intel do
      url "https://github.com/0xtlt/md2pdf/releases/download/v#{version}/md2pdf-macos-x86_64.tar.gz"
      sha256 "e50d7b1d7d8da92be494bc0eecb2f90ae3b1661a8633805062ee8329c74539ee"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/0xtlt/md2pdf/releases/download/v#{version}/md2pdf-linux-x86_64.tar.gz"
      sha256 "510fe61507f8c0938566cba71b3af0d779d7d8af84de477706187698b99ee4e0"
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
