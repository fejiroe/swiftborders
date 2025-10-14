import Foundation
import SwiftUI

struct Window {
    var bounds: CGRect
    let pid: Int
    var layer: Int
    
    init(bounds: CGRect, pid: Int, layer: Int) {
        self.bounds = bounds
        self.pid = pid
        self.layer = layer
    }
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
                if let boundsDict = winDict!["kCGWindowBounds"] as? [String: Any] {
                    if let xPos = boundsDict["X"] as? CGFloat,
                       let yPos = boundsDict["Y"] as? CGFloat,
                       let width = boundsDict["Width"] as? CGFloat,
                       let height = boundsDict["Height"] as? CGFloat {
                        let boundsRect = CGRect(x: xPos, y: yPos, width: width, height: height)
                        if let pid = winDict!["kCGWindowOwnerPID"] as? Int,
                           let layer = winDict!["kCGWindowLayer"] as? Int {
                            let winInfo: Window = Window(bounds: boundsRect, pid: pid, layer: layer)
                            winRects.append(winInfo)
                        }
                    }
                }
            }
        }
        return winRects
    }
    return getWinRects()
}
