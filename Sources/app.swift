import Foundation
import SwiftUI

@MainActor func quit() {
    NSApp.terminate(nil)
}

final class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!
    func applicationDidFinishLaunching(_ notification: Notification) {
        let screen = NSScreen.main!
        let frame  = screen.frame   // full screen rectangle

        window = NSWindow(
            contentRect: frame,
            styleMask: [.borderless],
            backing: .buffered,
            defer: false)

        window.titlebarAppearsTransparent = true
        window.isOpaque = false
        window.backgroundColor = .clear
        window.center()
        window.isMovable = false
        window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        window.contentView = NSHostingView(rootView:
            BorderView()
                .ignoresSafeArea())
        window.makeKeyAndOrderFront(nil)
    }
}

@main struct swiftborders: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
    }
}
