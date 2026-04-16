class VerbatimCuda < Formula
  desc "Verbatim speech-to-text with NVIDIA CUDA GPU acceleration"
  homepage "https://github.com/mkamran67/verbatim"
  version "0.1.0"
  license "MIT"

  depends_on :linux
  depends_on arch: :x86_64

  url "https://github.com/mkamran67/verbatim/releases/download/First-Stable-Release/verbatim-#{version}-linux-amd64-cuda.tar.gz"
  sha256 "94709d588bb5655c9aa86bf8d513b3b010171e582cf5ce44c7efe42401f06a30"

  conflicts_with "verbatim", because: "both install the `verbatim` binary"
  conflicts_with "verbatim-vulkan", because: "both install the `verbatim` binary"

  def install
    bin.install "verbatim"
  end

  def caveats
    <<~EOS
      You must be in the 'input' group for the global hotkey:
        sudo usermod -aG input $USER
      Then log out and back in.

      CUDA build installed. NVIDIA drivers are required at runtime
      (CUDA toolkit is NOT needed — it's statically linked).
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/verbatim --version 2>&1")
  end
end
