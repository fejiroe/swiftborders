import Foundation
import SwiftUI

@MainActor func quit() {
    NSApp.terminate(nil)
}

final class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!
    func applicationDidFinishLaunching(_ notification: Notification) {
        let frame = NSScreen.main!.frame
        window = NSWindow(
            contentRect: frame,
            styleMask: [.borderless],
            backing: .buffered,
            defer: false)
        window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        window.contentView = NSHostingView(rootView:
            BorderView()
                .ignoresSafeArea())
        window.titlebarAppearsTransparent = true
        window.makeKeyAndOrderFront(nil)
        window.level = .statusBar
        window.backgroundColor = .clear
        window.isOpaque = false
        window.isMovable = false
        window.center()
    }
}

@main struct swiftborders: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {}
}
