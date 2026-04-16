class VerbatimVulkan < Formula
  desc "Verbatim speech-to-text with Vulkan GPU acceleration (NVIDIA + AMD)"
  homepage "https://github.com/mkamran67/verbatim"
  version "0.1.0"
  license "MIT"

  depends_on :linux
  depends_on arch: :x86_64

  url "https://github.com/mkamran67/homebrew-verbatim/releases/download/v#{version}/verbatim-#{version}-linux-amd64-vulkan.tar.gz"
  sha256 "bfb8eb17e812185c53dbff28f4fa1cda32eede681b5f32df60d6bb4c6d4f58d3"

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
