import SwiftUI
import Foundation

struct BorderView: View {
    @State private var winList: [Window] = getWindows().filter {$0.layer == 0}
    var cornerRadius: CGFloat = 0
    var shadowRadius: CGFloat = 10
    var activeColor = Color.white
    var inactiveColor = Color.blue
    var body: some View {
        GeometryReader { geo in
            ForEach(winList, id: \.pid) { window in
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(activeColor, lineWidth: 1)
                    .frame(width: window.bounds.width)
                    .frame(height: window.bounds.height)
                    .position(x: window.bounds.midX,
                              y: geo.size.height - window.bounds.midY)
                    .background(.clear)
                    .shadow(radius: shadowRadius)
                    .onAppear {
                    }
            }
        }
    }
}
