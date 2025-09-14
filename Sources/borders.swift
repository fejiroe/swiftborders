import SwiftUI
import Foundation
import ArgumentParser

// need to take cli args to set border colours etc

// if window count is not 0
// first get dimensions of window(s), then pass to rectangle dimensions
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

@MainActor
func getWindowList() -> CFArray? {
    let windowList = CGWindowListCopyWindowInfo(.optionOnScreenOnly, kCGNullWindowID)
    return windowList
}

/*
// need some sort of listener/callback for window changes (new/delete/move/resize).
// consider multiple functions
func updateWindowList() {

}
*/

@MainActor
var windowList = getWindowList()
// CGWindowBounds: Height, Width, X, Y
// do for each loop over list for rects
// active vs inactive colour
@main
struct swiftborders: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var winCount = Int(CFArrayGetCount(windowList))
    var body: some Scene {
        WindowGroup {
            ForEach(0..<winCount) { window in
                //if let winProperties = CFArrayGetValueAtIndex(windowList, window) {
                Rectangle()
                    .frame(maxWidth: 240)
                    .frame(maxHeight: 150)
                    .background(.clear)
                    .border(.white)
                    .shadow(radius: 10)
            }
        }
        .windowStyle(.plain)
        .windowResizability(.contentSize)
    }
}
