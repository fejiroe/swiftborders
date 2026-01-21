import AppKit
import Combine
import CoreGraphics
import Foundation

final class WindowObserver: NSObject, ObservableObject {
    @Published var winList: [Window] = []
    @Published var activeWin: Window? = nil
    private var timerCancellable: AnyCancellable?
    private var lastHash = 0
    private let interval: TimeInterval
    init(interval: TimeInterval = 0.1) {
        self.interval = interval
        super.init()
        refreshWindows()
        startTimer()
        NSWorkspace.shared.notificationCenter.addObserver(
            self,
            selector: #selector(activeAppChanged(_:)),
            name: NSWorkspace.didActivateApplicationNotification,
            object: nil,
        )
    }
    func refreshWindows() {
        let windows = getWindows().filter { $0.layer == 0 }
        let newHash = windows.reduce(0) { $0 ^ Int($1.bounds.hashValue) ^ $1.pid }
        guard newHash != lastHash else { return }
        lastHash = newHash
        winList = windows
        activeWin = getActiveWin()
    }
    @objc private func activeAppChanged(_ notification: Notification) {
        activeWin = getActiveWin()
    }
    private func startTimer() {
        timerCancellable?.cancel()
        timerCancellable = Timer.publish(every: interval, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in self?.refreshWindows() }
    }
}
