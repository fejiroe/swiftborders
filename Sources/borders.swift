import SwiftUI
import Foundation

// need to take cli args to set border colours etc

// if window count is not 0
// first get dimensions of window(s), then pass to rectangle dimensions

// active vs inactive colour
@MainActor 
let testList = CGWindowListCopyWindowInfo(.optionOnScreenOnly, kCGNullWindowID)


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

// do for each loop over list for rects
@main
struct swiftborders: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var winCount = Int(CFArrayGetCount(testList))
    var body: some Scene {
        WindowGroup {
            Rectangle()
                .background(.clear)
                .border(.white)
                .shadow(radius: 10)
                .frame(maxWidth: 240)
                .frame(maxHeight: 150)
        }
        .windowStyle(.plain)
        .windowResizability(.contentSize)
    }
}
