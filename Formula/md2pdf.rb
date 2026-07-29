class Md2pdf < Formula
  desc "Fast, standalone Markdown to PDF converter written in Rust"
  homepage "https://github.com/0xtlt/md2pdf"
  version "3.2.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/0xtlt/md2pdf/releases/download/v#{version}/md2pdf-macos-arm64.tar.gz"
      sha256 "cb6a4c7c1ae392c97309685612539e7141dc841f66c362e38b17aef14775f0c2"
    end
    on_intel do
      url "https://github.com/0xtlt/md2pdf/releases/download/v#{version}/md2pdf-macos-x86_64.tar.gz"
      sha256 "bfc7081e6c760d9319b05946138e320a11b26edd34724483e5e00fea19f28284"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/0xtlt/md2pdf/releases/download/v#{version}/md2pdf-linux-x86_64.tar.gz"
      sha256 "4d576aa4bec58fd6b0f48e8412ff4991ad06873f8e07b12a9fd4a995ea39c99f"
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
