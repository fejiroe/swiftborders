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

    func testFunc() {
        for window in 0...winCount {
            let ref = CFArrayGetValueAtIndex(winArray, window)
            let dict: CFDictionary? = unsafeBitCast(ref, to: CFDictionary?.self)
            let key: String = "kCGWindowBounds"
            let winBoundsRef = CFDictionaryGetValue(dict, key)
                    // let winBounds = unsafeBitCast(winBoundsRef, to: CFDictionary?.self)
            print(winBoundsRef as Any)
        }
    }

    func printWin() {
        for window in 0...winCount {
            if let ref = CFArrayGetValueAtIndex(winArray, window) {
                let dict: CFDictionary? = unsafeBitCast(ref, to: CFDictionary?.self)
                print(dict)
            }
        }
    }
    testFunc()
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
