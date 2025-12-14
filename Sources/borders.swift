import SwiftUI
import Foundation

struct BorderView: View {
    @State private var winList: [Window] = getWindows().filter {$0.layer == 0}
    let config: BorderConfig
    init(config: BorderConfig) {self.config = config}
    @State var activeWin: Window? = getActiveWin()
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect() // replace timer with some sort of callback
    let mainFrame: CGRect = NSScreen.main?.frame ?? .zero
    var body: some View {
        GeometryReader { geo in
            ForEach(winList, id: \.pid) { window in
                RoundedRectangle(cornerRadius: config.cornerRadius)
                    // need to add 1px padding, currently draws on window not around
                    .stroke(window.pid == activeWin?.pid ? config.activeColor : config.inactiveColor, lineWidth: config.borderWidth)
                    .frame(width: window.bounds.width)
                    .frame(height: window.bounds.height)
                    .position(x: window.bounds.midX,
                            // need to find source of the offset
                            y: (window.bounds.midY - 30))
                    .background(.clear)
                    .shadow(radius: config.shadowRadius)
                    .onReceive(timer) { _ in
                        winList = getWindows().filter {$0.layer==0}
                        activeWin = getActiveWin()
                    }
            }
        }
    }
}
