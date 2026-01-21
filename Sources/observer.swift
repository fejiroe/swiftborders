import AppKit
import CoreGraphics
import Foundation

final class WindowObserver: NSObject, ObservableObject {
    @Published var winList: [Window] = []
    @Published var activeWin: Window? = nil
    private var windowChangedObserver: Any?
    override init() {
        super.init()
        refreshWindows()
        activeWin = getActiveWin()
        let centre = CFNotificationCenterGetDarwinNotifyCenter()
        CFNotificationCenterAddObserver(
            centre, Unmanaged.passUnretained(self).toOpaque(),
            { (_, observerPtr, name, _, _) in
                guard let observerPtr = observerPtr else { return }
                let selfObj = Unmanaged<WindowObserver>.fromOpaque(observerPtr)
                    .takeUnretainedValue()
                selfObj.refreshWindows()
            },
            "kCGWindowListChanged" as CFString,
            nil,
            .deliverImmediately
        )
        NSWorkspace.shared.notificationCenter.addObserver(
            self,
            selector: #selector(appDidActivate(_:)),
            name: NSWorkspace.didActivateApplicationNotification,
            object: nil,
        )
    }
    func refreshWindows() {
        winList = getWindows().filter { $0.layer == 0 }
    }
    @objc private func appDidActivate(_ notification: Notification) {
        activeWin = getActiveWin()
    }
}
