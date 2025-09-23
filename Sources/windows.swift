import Foundation
import SwiftUI

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
            var posRefVal: CFTypeRef?
            var posVal: AXValue
            var pos: CGPoint?
            /*
            posRef.initialize(to: posRefVal)
            
            // docs: Returns the value of an accessibility object's attribute.
            let copyPosSuccess = AXUIElementCopyAttributeValue(winElement, kAXPositionAttribute as CFString, posRef)
            if copyPosSuccess == AXError.success { // need to cover error cases
            /*
            docs:
            Decodes the structure stored in value and copies it into valuePtr.
            If the structure stored in value is not the same as requested by theType,
            the function returns false.
            */
            // AXValueGetValue(posRef, kAXValueCGPointType, pos)
            AXValueGetValue(posVal, AXValueType.cgPoint, posRef)
            // var winPos = AXValueGetValue(kAXPositionAttribute, positionVal, winElement)
            // winInfo.pid = ""
            // winInfo.position = AXValueGetValue(positionVal, kAXValueCGPointType, winInfo.position.self)
            // print(windowElement as Any)
            }
            */

            var sizeRef: UnsafeMutablePointer<CFTypeRef>
            var sizeVal: AXValue
            var size: CGSize
        }
    }
    testFunc()
}
// }
