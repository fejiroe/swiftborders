import Foundation
import SwiftUI

struct Window {
    var bounds: CGRect
    let pid: Int
    var layer: Int
}

@MainActor
func getWindows() -> [Window] {
    guard let winCFArray = CGWindowListCopyWindowInfo(.optionOnScreenOnly, kCGNullWindowID) else {
        return []
    }

    // let screenHeight = NSScreen.main?.frame.height ?? 0

    let cfDicts = (0..<CFArrayGetCount(winCFArray)).compactMap { index -> [String: Any]? in
        let value = CFArrayGetValueAtIndex(winCFArray, index)
        return unsafeBitCast(value, to: CFDictionary?.self) as? [String: Any]
    }

    // let raw = cfDicts.compactMap { dict -> Window? in
    return cfDicts.compactMap { dict in
        guard let boundsDict = dict[kCGWindowBounds as String] as? [String: Any],
              let xPos = boundsDict["X"] as? CGFloat,
              let yPos = boundsDict["Y"] as? CGFloat,
              let width = boundsDict["Width"] as? CGFloat,
              let height = boundsDict["Height"] as? CGFloat,
              let pid   = dict[kCGWindowOwnerPID as String] as? Int,
              let layer = dict[kCGWindowLayer as String] as? Int
        else { return nil }

        let bounds = CGRect(x: xPos, y: yPos, width: width, height: height)
        return Window(bounds: bounds, pid: pid, layer: layer)
    }
    // return raw.map { flipY($0, screenHeight: screenHeight) }
}

/*
func flipY(_ window: Window, screenHeight: CGFloat) -> Window {
    var win = window
    // gpt said in CG coordinates the origin is bottomleft, SwiftUI expects topleft, need to check docs
    win.bounds.origin.y = screenHeight - window.bounds.maxY
    return win
}
*/
