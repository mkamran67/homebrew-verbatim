class VerbatimCuda < Formula
  desc "Verbatim speech-to-text with NVIDIA CUDA GPU acceleration"
  homepage "https://github.com/mkamran67/verbatim"
  version "0.1.0"
  license "MIT"

  depends_on :linux
  depends_on arch: :x86_64

  url "https://github.com/mkamran67/verbatim/releases/download/First-Stable-Release/verbatim-#{version}-linux-amd64-cuda.tar.gz"
  sha256 "83436ba5b50f7feff22a1536dbe507cd5764d6ece3da8b59f43658d673ad6422"

  conflicts_with "verbatim", because: "both install the `verbatim` binary"
  conflicts_with "verbatim-vulkan", because: "both install the `verbatim` binary"

  def install
    bin.install "verbatim"
    # Rewrite Exec= to an absolute path so minimal graphical sessions
    # (Hyprland, i3, etc.) whose launcher environment doesn't include
    # Linuxbrew's bin can still find the binary.
    inreplace "verbatim.desktop", /^Exec=.*/, "Exec=#{opt_bin}/verbatim"
    (share/"applications").install "verbatim.desktop"
    (share/"icons/hicolor/512x512/apps").install "verbatim.png"
  end

  def caveats
    <<~EOS
      You must be in the 'input' group for the global hotkey:
        sudo usermod -aG input $USER
      Then log out and back in.

      To show Verbatim in your application launcher:
        mkdir -p ~/.local/share/applications ~/.local/share/icons/hicolor/512x512/apps
        ln -sf #{opt_share}/applications/verbatim.desktop ~/.local/share/applications/
        ln -sf #{opt_share}/icons/hicolor/512x512/apps/verbatim.png \\
               ~/.local/share/icons/hicolor/512x512/apps/
        update-desktop-database ~/.local/share/applications 2>/dev/null || true

      CUDA build installed. NVIDIA drivers are required at runtime
      (CUDA toolkit is NOT needed — it's statically linked).
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/verbatim --version 2>&1")
  end
end
