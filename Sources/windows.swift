import Foundation
import SwiftUI

struct WindowInfo {
    var pid: String
    var position: CGPoint
    var dimensions: CGSize
    var isFocused: Bool = false
}

@MainActor
func test() {
    func getWinArray() -> CFArray? {
        let windowsCFArray = CGWindowListCopyWindowInfo(.optionOnScreenOnly, kCGNullWindowID)
        return windowsCFArray
    }
    let winArray: CFArray? = getWinArray()
    let winCount = Int(CFArrayGetCount(winArray))

    func testFunc() {
        for window in 0...winCount {
            let ref = CFArrayGetValueAtIndex(winArray, window)
            let windowElement: AXUIElement = unsafeBitCast(ref, to: AXUIElement.self)
            // var winInfo: WindowInfo
            // let key: String = "kCGWindowBounds"
            print(windowElement as Any)
        }
    }
    testFunc()
}
