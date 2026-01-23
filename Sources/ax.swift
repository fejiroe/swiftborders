import ApplicationServices
import Foundation

func ensureAccessibilityPermission() {
    let options =
        [
            "AXTrustedCheckOptionPrompt": true
        ] as CFDictionary
    let trusted = AXIsProcessTrustedWithOptions(options)
    if !trusted {
        print("accessibility permission not granted – user prompted.")
    } else {
        print("already trusted; can use AXUIElement APIs.")
    }
}
