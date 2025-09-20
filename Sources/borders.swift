import SwiftUI
import Foundation
import ArgumentParser

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

func testFunc() {
    func getWinArray() -> CFArray? {
        let windowsCFArray = CGWindowListCopyWindowInfo(.optionOnScreenOnly, kCGNullWindowID)
            return windowsCFArray
    }
    let winArray: CFArray? = getWinArray()
    let winCount = Int(CFArrayGetCount(winArray))

    func toRect() {
        for window in 0...winCount {
            if let ref = CFArrayGetValueAtIndex(winArray, window) {
                // let dict = ref.load(as: CFDictionary?.self)
                let dict: CFDictionary? = unsafeBitCast(ref, to: CFDictionary?.self)
                let key: String = "kCGWindowBounds"
                if let winBounds = CFDictionaryGetValue(dict, key) {
                    print(winBounds)
                }
            }
        }
    }

    func printWin() {
    }
    toRect()
}

@main struct swiftborders: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
        // var windowList: CFArray?
    var body: some Scene {
        WindowGroup {
            // ForEach(0..<winCount) { window in windowList
                Rectangle()
                    .frame(maxWidth: 240)
                    .frame(maxHeight: 150)
                    .background(.clear)
                    .border(.white)
                    .shadow(radius: 10)
                    .onAppear {
                        testFunc()
                    }
                // }
        }
        .windowStyle(.plain)
        .windowResizability(.contentSize)
    }
}
