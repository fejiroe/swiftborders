import ApplicationServices
import Foundation
import SwiftUI

struct Window {
    var bounds: CGRect
    let pid: Int
    var layer: Int
    let windowNumber: CGWindowID
    var id: Self { self }
}

func getWindows() -> [Window] {
    guard let winCFArray = CGWindowListCopyWindowInfo(.optionOnScreenOnly, kCGNullWindowID) else {
        return []
    }
    let cfDicts = (0..<CFArrayGetCount(winCFArray)).compactMap { index -> [String: Any]? in
        let value = CFArrayGetValueAtIndex(winCFArray, index)
        return unsafeBitCast(value, to: CFDictionary?.self) as? [String: Any]
    }
    return cfDicts.compactMap { dict in
        guard let boundsDict = dict[kCGWindowBounds as String] as? [String: Any],
            let xPos = boundsDict["X"] as? CGFloat,
            let yPos = boundsDict["Y"] as? CGFloat,
            let width = boundsDict["Width"] as? CGFloat,
            let height = boundsDict["Height"] as? CGFloat,
            let pid = dict[kCGWindowOwnerPID as String] as? Int,
            let layer = dict[kCGWindowLayer as String] as? Int,
            let winNum = dict[kCGWindowNumber as String] as? CGWindowID
        else { return nil }

        let bounds = CGRect(x: xPos, y: yPos, width: width, height: height)
        return Window(bounds: bounds, pid: pid, layer: layer, windowNumber: winNum)
    }
}

func getActiveWin() -> Window? {
    guard let frontApp = NSWorkspace.shared.frontmostApplication else { return nil }
    let pid = frontApp.processIdentifier
    let windows = getWindows().filter { $0.pid == pid && $0.layer == 0 }
    return windows.sorted(by: { $0.layer < $1.layer }).last
}
