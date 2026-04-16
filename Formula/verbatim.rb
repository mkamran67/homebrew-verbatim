class Verbatim < Formula
  desc "Real-time speech-to-text with push-to-talk hotkey"
  homepage "https://github.com/mkamran67/verbatim"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mkamran67/homebrew-verbatim/releases/download/v#{version}/verbatim-#{version}-macos-arm64.tar.gz"
      sha256 "REPLACE_WITH_MACOS_ARM64_SHA256"
    else
      url "https://github.com/mkamran67/homebrew-verbatim/releases/download/v#{version}/verbatim-#{version}-macos-x86_64.tar.gz"
      sha256 "REPLACE_WITH_MACOS_X86_64_SHA256"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/mkamran67/homebrew-verbatim/releases/download/v#{version}/verbatim-#{version}-linux-arm64-cpu.tar.gz"
      sha256 "REPLACE_WITH_LINUX_ARM64_CPU_SHA256"
    else
      url "https://github.com/mkamran67/homebrew-verbatim/releases/download/v#{version}/verbatim-#{version}-linux-amd64-cpu.tar.gz"
      sha256 "REPLACE_WITH_LINUX_AMD64_CPU_SHA256"
    end
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
