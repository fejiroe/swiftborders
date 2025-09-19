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
// func getWindowList() {
func getWindowList() -> CFArray? {
    let windowsCFArray = CGWindowListCopyWindowInfo(.optionOnScreenOnly, kCGNullWindowID)
    return windowList
}

func setColour() {
    // ideally take argument for active/inactive
}

// /*
// need some sort of listener/callback for window changes (new/delete/move/resize).
// consider multiple functions. updateWinCount() ?
@MainActor
func updateWinList() {
    windowList = getWindowList()
}
// */

@MainActor
var windowList = getWindowList()
// CGWindowBounds: Height, Width, X, Y
// do for each loop over list for rects
// active vs inactive colour
@MainActor
func printWindowInfo() -> Void {
    var winCount = Int(CFArrayGetCount(windowList))
    // var winDicts: [Any]
    // var currentWindowProperties: Any
    for window in 0...winCount {
       // let input = CFArrayGetValueAtIndex(windowList, window)
       // winDicts.append(input)
       // let output = winDicts[window]
       // print(input)
       // currentWindowProperties = input
       // NSLog("%@", CFDictionaryGetValue(input, kCGWindowBounds))
       // NSLog("%@", input)
       // var test = CFDictionaryGetValue(kCGWindowBounds, input)
       // let ref: CFDictionary = CFArrayGetValueAtIndex(windowList, window)
    }
}

@main
struct swiftborders: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    // var winCount = Int(CFArrayGetCount(windowList))
    var body: some Scene {
        WindowGroup {
            // ForEach(0..<winCount) { window in windowList // find way to cast array ?
                // if let winProperties = CFArrayGetValueAtIndex(windowList, window) {
                Rectangle()
                    .frame(maxWidth: 240)
                    .frame(maxHeight: 150)
                    .background(.clear)
                    .border(.white)
                    .shadow(radius: 10)
                    .onAppear {
                        updateWinList()
                        printWindowInfo()
                    }
            // }
        }
        .windowStyle(.plain)
        .windowResizability(.contentSize)
    }
}
