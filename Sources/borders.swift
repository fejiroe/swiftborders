import SwiftUI
//import ArgumentParser

// need to take cli args to set border colours etc

// if window count is not 0
// first get dimensions of window(s), then pass to rectangle dimensions

// active vs inactive colour

@MainActor
func quit() {
    NSApp.terminate(nil)
}

final class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        if let window = NSApplication.shared.windows.first {
           window.titlebarAppearsTransparent = true
           window.isOpaque = false
           window.backgroundColor = NSColor.clear
        }
    }
}

@main
struct swiftborders: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
    }
}
