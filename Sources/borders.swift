import SwiftUI
import Foundation

struct BorderView: View {
    @State private var winList: [Window] = getWindows().filter {$0.layer == 0}
    var cornerRadius: CGFloat = 0
    var shadowRadius: CGFloat = 10
    var activeColor = Color.red
    var inactiveColor = Color.white
    @State var activeWin: Window? = getActiveWin()
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect() // replace timer with some sort of callback
    let mainFrame: CGRect = NSScreen.main?.frame ?? .zero
    var body: some View {
        GeometryReader { geo in
            ForEach(winList, id: \.pid) { window in
                RoundedRectangle(cornerRadius: cornerRadius)
                    // need to add padding, currently draws on window not around
                    .stroke(window.pid == activeWin?.pid ? activeColor : inactiveColor, lineWidth: 1)
                    .frame(width: window.bounds.width)
                    .frame(height: window.bounds.height)
                    .position(x: window.bounds.midX,
                            // need to find source of the offset
                            y: (window.bounds.midY - 30))
                    .background(.clear)
                    .shadow(radius: shadowRadius)
                    .onReceive(timer) { _ in
                        winList = getWindows().filter {$0.layer==0}
                        activeWin = getActiveWin()
                    }
            }
        }
    }
}
