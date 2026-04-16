class VerbatimVulkan < Formula
  desc "Verbatim speech-to-text with Vulkan GPU acceleration (NVIDIA + AMD)"
  homepage "https://github.com/mkamran67/verbatim"
  version "0.1.0"
  license "MIT"

  depends_on :linux

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/mkamran67/homebrew-verbatim/releases/download/v#{version}/verbatim-#{version}-linux-arm64-vulkan.tar.gz"
      sha256 "REPLACE_WITH_LINUX_ARM64_VULKAN_SHA256"
    else
      url "https://github.com/mkamran67/homebrew-verbatim/releases/download/v#{version}/verbatim-#{version}-linux-amd64-vulkan.tar.gz"
      sha256 "REPLACE_WITH_LINUX_AMD64_VULKAN_SHA256"
    end
  end

  conflicts_with "verbatim", because: "both install the `verbatim` binary"
  conflicts_with "verbatim-cuda", because: "both install the `verbatim` binary"

  def install
    bin.install "verbatim"
  end

  def caveats
    <<~EOS
      You must be in the 'input' group for the global hotkey:
        sudo usermod -aG input $USER
      Then log out and back in.

      Vulkan build installed. GPU drivers required at runtime:
        NVIDIA: nvidia-driver-* + libvulkan1
        AMD:    mesa-vulkan-drivers + libvulkan1
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/verbatim --version 2>&1")
  end
end
