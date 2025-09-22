import Foundation
import SwiftUI

@MainActor func quit() {
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

@main struct swiftborders: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup("swiftborders", id: "main") {
                BorderView()
                .background(.clear)
                }
        .windowStyle(.plain)
        .windowResizability(.contentSize)
    }
}
