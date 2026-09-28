cask "pastestack" do
  version "0.1.0"
  sha256 "e32d131f7ab69b636b98480703958833b917b94828da9d2070aa72a8e70dd632"

  url "https://github.com/MoizAhmedd/pastestack/releases/download/v#{version}/PasteStack.zip"
  name "PasteStack"
  desc "Menu bar app that stacks clipboard screenshots so one paste inserts them all"
  homepage "https://moizahmedd.github.io/pastestack/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "PasteStack.app"

  # Signed with the project's own certificate, not an Apple Developer ID, so it isn't notarized.
  # Removing the quarantine flag is what lets it open without a Gatekeeper dialog.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/PasteStack.app"], must_succeed: false
  end

  uninstall quit: "dev.pastestack.app"

  zap trash: [
    "~/Library/Caches/dev.pastestack.app",
    "~/Library/Preferences/dev.pastestack.app.plist",
  ]

  caveats <<~EOS
    PasteStack is signed with its own certificate rather than an Apple Developer ID, so
    Homebrew's quarantine flag is removed after install. Source: https://github.com/MoizAhmedd/pastestack

    Open it once to start it:
      open "#{appdir}/PasteStack.app"
  EOS
end
