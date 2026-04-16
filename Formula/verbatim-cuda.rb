class VerbatimCuda < Formula
  desc "Verbatim speech-to-text with NVIDIA CUDA GPU acceleration"
  homepage "https://github.com/mkamran67/verbatim"
  version "0.1.0"
  license "MIT"

  depends_on :linux

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/mkamran67/homebrew-verbatim/releases/download/v#{version}/verbatim-#{version}-linux-arm64-cuda.tar.gz"
      sha256 "REPLACE_WITH_LINUX_ARM64_CUDA_SHA256"
    else
      url "https://github.com/mkamran67/homebrew-verbatim/releases/download/v#{version}/verbatim-#{version}-linux-amd64-cuda.tar.gz"
      sha256 "REPLACE_WITH_LINUX_AMD64_CUDA_SHA256"
    end
  end

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
