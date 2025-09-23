import Foundation
import SwiftUI

/*
https://github.com/tornikegomareli/space-borders
https://stackoverflow.com/questions/25575195/how-to-use-axuielementcopyattributevalue-from-swift
https://stackoverflow.com/questions/49285656/swift-4-axvaluegetvalue-optional-value-is-nil-but-debugger-shows-a-value

*/

// struct WindowManager {
struct WindowInfo {
    var pid: String
    var winRef: UnsafeRawPointer
    var pos: CGPoint
    var xySize: CGSize
    var isFocused: Bool = false
}

func getWinArray() -> CFArray? {
        let winCFArray = CGWindowListCopyWindowInfo(.optionOnScreenOnly, kCGNullWindowID)
        return winCFArray
}

@MainActor
func test() {
    let winArray: CFArray? = getWinArray()
    let winCount = Int(CFArrayGetCount(winArray))

    func getWinInfo() {
        for window in 0...winCount {
            let ref = CFArrayGetValueAtIndex(winArray, window)
            let winElement: AXUIElement = unsafeBitCast(ref, to: AXUIElement.self)

            var winInfo: WindowInfo

            var posRef: UnsafeMutablePointer<CFTypeRef?>
            var posVal: AnyObject?
            var pos: CGPoint?
            let copyPos = AXUIElementCopyAttributeValue(winElement, kAXPositionAttribute as CFString, &posVal)
            if copyPos == AXError.success { // need to cover error cases
                // print(posVal as! AXUIElement)
                print(posVal)
            /*
            docs:
            Decodes the structure stored in value and copies it into valuePtr.
            If the structure stored in value is not the same as requested by theType,
            the function returns false.
            */
            // AXValueGetValue(posVal as! AXUIElement, AXValueType.cgPoint, posRef)
            // var winPos = AXValueGetValue(kAXPositionAttribute, positionVal, winElement)
            // winInfo.pid = ""
            // winInfo.position = AXValueGetValue(positionVal, kAXValueCGPointType, winInfo.position.self)
            // print(windowElement as Any)
            } else {print(copyPos)}

            var sizeVal: CFTypeRef?
            var size: CGSize
            let copySize = AXUIElementCopyAttributeValue(winElement, kAXSizeAttribute as CFString, &sizeVal)
            if copySize == AXError.success {
                var sizeRef: UnsafeMutablePointer<CFTypeRef>
                var val = CGSize.zero
                // AXValueGetValue(sizeVal, AXValueType.cgSize, &val)
            }
        }
    }
    getWinInfo()
}
// }
