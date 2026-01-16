import Foundation
import SwiftUI

struct BorderView: View {
    let config: BorderConfig
    init(config: BorderConfig) { self.config = config }
    @State private var winList: [Window] = getWindows().filter { $0.layer == 0 }
    @State var activeWin: Window? = getActiveWin()
    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()  // replace timer with some sort of callback when screen updates
    var body: some View {
        GeometryReader { geo in
            ForEach(winList, id: \.pid) { window in
                let borderColour =
                    window.pid == activeWin?.pid ? config.activeColor : config.inactiveColor
                RoundedRectangle(cornerRadius: config.cornerRadius)
                    // need to add 1px padding, currently draws on window not around
                    .stroke(borderColour, lineWidth: config.borderWidth)
                    .frame(width: window.bounds.width)
                    .frame(height: window.bounds.height)
                    .position(
                        x: window.bounds.midX,
                        // need to find source of the offset, don't want to hardcode px val
                        y: window.bounds.midY
                    )
                    .background(.clear)
                    .shadow(radius: config.shadowRadius)
            }
            .onReceive(timer) { _ in
                winList = getWindows().filter { $0.layer == 0 }
                activeWin = getActiveWin()
            }
        }
    }
}
