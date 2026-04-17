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
    sha256 "0e896486fa2d08a1c9210c248e45baa1f0229434cd177da8b0d96a6cfbe84833"
  end

  conflicts_with "verbatim-cuda", because: "both install the `verbatim` binary"
  conflicts_with "verbatim-vulkan", because: "both install the `verbatim` binary"

  def install
    bin.install "verbatim"
    on_linux do
      # Rewrite Exec= to an absolute path so minimal graphical sessions
      # (Hyprland, i3, etc.) whose launcher environment doesn't include
      # Linuxbrew's bin can still find the binary.
      inreplace "verbatim.desktop", /^Exec=.*/, "Exec=#{opt_bin}/verbatim"
      (share/"applications").install "verbatim.desktop"
      (share/"icons/hicolor/512x512/apps").install "verbatim.png"
    end
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

        To show Verbatim in your application launcher:
          mkdir -p ~/.local/share/applications ~/.local/share/icons/hicolor/512x512/apps
          ln -sf #{opt_share}/applications/verbatim.desktop ~/.local/share/applications/
          ln -sf #{opt_share}/icons/hicolor/512x512/apps/verbatim.png \\
                 ~/.local/share/icons/hicolor/512x512/apps/
          update-desktop-database ~/.local/share/applications 2>/dev/null || true

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
