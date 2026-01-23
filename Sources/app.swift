import Combine
import Foundation
import SwiftUI

@MainActor func quit() { NSApp.terminate(nil) }

final class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!
    let config = BorderConfig()
    private var cancellables = Set<AnyCancellable>()
    func applicationDidFinishLaunching(_ notification: Notification) {
        let frame = NSScreen.main!.frame
        window = NSWindow(
            contentRect: frame,
            styleMask: [.borderless],
            backing: .buffered,
            defer: false)
        window.collectionBehavior = [
            .canJoinAllSpaces,
            .fullScreenAuxiliary,
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
            .store(in: &cancellables)
        ensureAccessibilityPermission()
    }
}

@main struct swiftborders: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    init() {
        let args = CommandLine.arguments
        if args.contains("--start") || args.contains("--stop") {
            let cli = Cli()
            if args.contains("--start") {
                cli.runLaunchCtl("bootstrap")
            } else if args.contains("--stop") {
                cli.runLaunchCtl("bootout")
            }
            exit(0)
        }
    }
    var body: some Scene {}
}
