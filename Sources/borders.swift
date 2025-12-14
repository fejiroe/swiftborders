import SwiftUI
import Foundation

struct BorderView: View {
    @State private var winList: [Window] = getWindows().filter {$0.layer == 0}
    var cornerRadius: CGFloat = 0
    var shadowRadius: CGFloat = 10
    var activeColor = Color.red
    var inactiveColor = Color.white
    @State var activeWin: Window? = getActiveWin()
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    var body: some View {
            ForEach(winList, id: \.pid) { window in
                RoundedRectangle(cornerRadius: cornerRadius)
                    // need to add padding, currently draws on window not around
                    .stroke(window.pid == activeWin?.pid ? activeColor : inactiveColor, lineWidth: 1)
                    .frame(width: window.bounds.width)
                    .frame(height: window.bounds.height)
                    .position(x: window.bounds.midX,
                            y: window.bounds.midY)
                    .background(.clear)
                    .shadow(radius: shadowRadius)
                    .onReceive(timer) { _ in
                        winList = getWindows().filter {$0.layer==0}
                        activeWin = getActiveWin()
            }
        }
    }
}
