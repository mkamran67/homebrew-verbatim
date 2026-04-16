class Verbatim < Formula
  desc "Real-time speech-to-text with push-to-talk hotkey"
  homepage "https://github.com/mkamran67/verbatim"
  version "0.1.0"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/mkamran67/verbatim/releases/download/First-Stable-Release/verbatim-#{version}-macos-arm64.tar.gz"
    sha256 "REPLACE_WITH_MACOS_ARM64_SHA256"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/mkamran67/verbatim/releases/download/First-Stable-Release/verbatim-#{version}-linux-amd64-cpu.tar.gz"
    sha256 "8300475934ac95bde0ffa81720137a6be5db01a04fe5ba8038e445ec418e2757"
  end

  conflicts_with "verbatim-cuda", because: "both install the `verbatim` binary"
  conflicts_with "verbatim-vulkan", because: "both install the `verbatim` binary"

  def install
    bin.install "verbatim"
  end

  def caveats
    on_macos do
      return <<~EOS
        Grant Accessibility permissions for keyboard simulation:
          System Settings > Privacy & Security > Accessibility
        Grant Microphone permissions when prompted on first launch.
        Metal GPU acceleration is enabled automatically.
      EOS
    end

    on_linux do
      return <<~EOS
        You must be in the 'input' group for the global hotkey:
          sudo usermod -aG input $USER
        Then log out and back in.

        CPU build installed. For GPU acceleration:
          brew install mkamran67/verbatim/verbatim-cuda    # NVIDIA
          brew install mkamran67/verbatim/verbatim-vulkan  # NVIDIA + AMD
      EOS
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/verbatim --version 2>&1")
  end
end
