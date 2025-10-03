import Foundation
import SwiftUI

struct Window { // make this conform to view
    let bounds: CGRect
    let pid: Int
    let layer: Int
}

func getWinArray() -> CFArray? {
    let winCFArray = CGWindowListCopyWindowInfo(.optionOnScreenOnly, kCGNullWindowID)
    return winCFArray
}

@MainActor
func getWindows() -> [Window] {
    let winArray: CFArray? = getWinArray()
    let winCount = Int(CFArrayGetCount(winArray))

    func getWinRects() -> [Window] {
        var winRects: [Window] = []
        for window in 0...winCount {
            let ref = CFArrayGetValueAtIndex(winArray, window)
            if let winCFDict = unsafeBitCast(ref, to: CFDictionary?.self) {
                let winDict = winCFDict as? [String: Any]
                let winBounds = winDict!["kCGWindowBounds"] as? [String: Any]
                let xPos = winBounds!["X"] as? CGFloat
                let yPos = winBounds!["Y"] as? CGFloat
                let height = winBounds!["Height"] as? CGFloat
                let width = winBounds!["Width"] as? CGFloat
                let boundsRect = CGRect.init(x: xPos!, y: yPos!, width: width!, height: height!)
                let winPid = winDict!["kCGWindowOwnerPID"] as? Int
                let winLayer = winDict!["kCGWindowLayer"] as? Int
                let winInfo: Window = Window(bounds: boundsRect, pid: winPid!, layer: winLayer!)
                winRects.append(winInfo)
                // print(winRects[window] as Any) /* works */
            }
        }
        return winRects
    }
    return getWinRects()
}
