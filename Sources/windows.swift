import Foundation
import SwiftUI

@MainActor
func test() {
    func getWinArray() -> CFArray? {
        let winCFArray = CGWindowListCopyWindowInfo(.optionOnScreenOnly, kCGNullWindowID)
        return winCFArray
    }
    let winArray: CFArray? = getWinArray()
    let winCount = Int(CFArrayGetCount(winArray))

    func getWinRects() {
        for window in 0...winCount {
            let ref = CFArrayGetValueAtIndex(winArray, window)
            let winElement: CFDictionary = unsafeBitCast(ref, to: CFDictionary.self)
            let winBoundsRef = CFDictionaryGetValue(winElement, "kCGWindowBounds") // null pointer ?
            let winBounds = unsafeBitCast(winBoundsRef, to: CFDictionary.self)
            // var cgRect = CGRect.zero
            // if CGRectMakeWithDictionaryRepresentation(winBounds as CFDictionary?, &cgRect) {
            let cgRect = CGRect.init(dictionaryRepresentation: winBounds)
            // let nsRect = NSRectToCGRect(cgRect)
            print(cgRect?.height as Any)
            // if let winBounds: [String: Int]? = (winElement as NSDictionary)["kCGWindowBounds"] {
                // var height = (winBounds!)["Height"]
                // print(height as Any)
            // }
            // if let winBounds = (winElement as NSDictionary)["kCGWindowBounds"] {
            //     print(winBounds)
            // }
        }
    }
    getWinRects()
}
