class Md2pdf < Formula
  desc "Fast, standalone Markdown to PDF converter written in Rust"
  homepage "https://github.com/0xtlt/md2pdf"
  version "3.4.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/0xtlt/md2pdf/releases/download/v#{version}/md2pdf-macos-arm64.tar.gz"
      sha256 "5e777d1a9d1f91740c16b33428e3e1b08e4595bf1805b4dbb1ca4da9af5f0fdb"
    end
    on_intel do
      url "https://github.com/0xtlt/md2pdf/releases/download/v#{version}/md2pdf-macos-x86_64.tar.gz"
      sha256 "bbc052b3e246517eafeee1915f2c00b023ae70a7c3c70bc419fd763e4ed1c8ac"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/0xtlt/md2pdf/releases/download/v#{version}/md2pdf-linux-x86_64.tar.gz"
      sha256 "e09d3c7a17e3ad40ec057403d96653f388b4763c9ea2060ca512ac453d402a68"
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
