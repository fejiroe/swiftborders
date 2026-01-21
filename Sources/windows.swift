import ApplicationServices
import Cocoa
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

func focusedWindowID() -> CGWindowID? { /* requires accesibility permissions */
    guard let frontApp = NSWorkspace.shared.frontmostApplication else { return nil }
    let kAXWindowNumberAttribute = "AXWindowNumber" as CFString

    let appElem = AXUIElementCreateApplication(frontApp.processIdentifier)

    var focusObj: CFTypeRef?
    let result = AXUIElementCopyAttributeValue(
        appElem,
        kAXFocusedWindowAttribute as CFString,
        &focusObj)
    guard result == .success else { return nil }
    guard let winRef = focusObj else { return nil }

    var winNumObj: CFTypeRef?
    let winResult = AXUIElementCopyAttributeValue(
        winRef as! AXUIElement,
        kAXWindowNumberAttribute as CFString,
        &winNumObj)
    guard winResult == .success, let num = winNumObj as? CGWindowID else { return nil }

    return num
}

func getActiveWin() -> Window? {
    guard let winID = focusedWindowID() else { return nil }
    return getWindows().first(where: { $0.windowNumber == winID })
}
