class AutoWallpaper < Formula
  desc "Keep macOS wallpaper in sync with light and dark appearance"
  homepage "https://github.com/tomaskub/auto-wallpaper"
  url "https://github.com/tomaskub/auto-wallpaper/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "e1921e5877b9cfe4d4aa851410e834c1dafce3802d3fc961ab9329950a15ec3b"
  license "GPL-3.0-or-later"

  depends_on arch: :arm64
  depends_on macos: :sequoia

  def fetch
    configure_swiftpm
    system "swift", "package", "resolve", "--disable-sandbox",
           "--package-path", buildpath, *swiftpm_paths
  end

  def install
    configure_swiftpm
    system "swift", "build", "--configuration", "release",
           "--disable-sandbox",
           "--disable-automatic-resolution",
           *swiftpm_paths,
           "--product", "auto-wallpaper"
    bin.install ".build/release/auto-wallpaper"
  end

  service do
    run [opt_bin/"auto-wallpaper", "watch"]
    keep_alive crashed: true
    log_path var/"log/auto-wallpaper.log"
    error_log_path var/"log/auto-wallpaper.log"
  end

  test do
    output = shell_output("#{bin}/auto-wallpaper status")
    assert_match "Configuration:", output
    assert_match "Appearance:", output
    assert_match "Configured:", output
  end

  private

  def configure_swiftpm
    ENV["CLANG_MODULE_CACHE_PATH"] = buildpath/"clang-module-cache"
    ENV["SWIFTPM_MODULECACHE_OVERRIDE"] = ENV["CLANG_MODULE_CACHE_PATH"]
  end

  def swiftpm_paths
    [
      "--cache-path", buildpath/"swiftpm-cache",
      "--config-path", buildpath/"swiftpm-config",
      "--security-path", buildpath/"swiftpm-security",
      "--scratch-path", buildpath/".build"
    ]
  end
end
