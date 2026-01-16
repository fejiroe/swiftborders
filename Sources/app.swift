import Foundation
import SwiftUI

@MainActor func quit() { NSApp.terminate(nil) }

final class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!
    let config = BorderConfig()
    func applicationDidFinishLaunching(_ notification: Notification) {
        /*
           DistributedNotificationCenter.default()
           addObserver(self,
selector: #selector(handleConfigUpdate(_:)),
name: BorderConfig.updateNotification,
object: nil)
         */
        let frame = NSScreen.main!.frame
        window = NSWindow(
            contentRect: frame,
            styleMask: [.borderless],
            backing: .buffered,
            defer: false)
        window.collectionBehavior = [
            .canJoinAllSpaces,
            .fullScreenAuxiliary
        ]
        window.contentView = NSHostingView(
            rootView:
                BorderView(config: config)
                .ignoresSafeArea())
        window.titlebarAppearsTransparent = true
        window.makeKeyAndOrderFront(nil)
        window.level = .statusBar
        window.backgroundColor = .clear
        window.isOpaque = false
        window.isMovable = false
        window.center()
        config.$enabledState
            .receive(on: RunLoop.main)
            .sink { enabled in self.window.contentView?.isHidden = !enabled }
    }
}

@main struct swiftborders: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {}
}
