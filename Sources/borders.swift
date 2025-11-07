import SwiftUI
import Foundation

struct BorderView: View {
    @State private var winList: [Window] = getWindows().filter {$0.layer == 0}
    var cornerRadius: CGFloat = 0
    var shadowRadius: CGFloat = 10
    var activeColor = Color.white
    var inactiveColor = Color.white

    var body: some View {
            ForEach(winList, id: \.pid) { window in
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(activeColor, lineWidth: 1)
                    .frame(maxWidth: window.bounds.width)
                    .frame(maxHeight: window.bounds.height)
                    .position(x: window.bounds.minX,
                              y: window.bounds.minY)
                    .background(.clear)
                    .shadow(radius: shadowRadius)
                    .onAppear {
                    }
            }
    }
}
