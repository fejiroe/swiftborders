import SwiftUI
import Foundation

struct BorderView: View {
    @State private var winList: [Window] = getWindows()
    var body: some View {
            ForEach(winList, id: \.pid) { window in
                RoundedRectangle(cornerRadius: 0)
                    .stroke(Color.white, lineWidth: 1)
                    .frame(maxWidth: window.bounds.width)
                    .frame(maxHeight: window.bounds.height)
                    .position(x: window.bounds.minX,
                              y: window.bounds.minY)
                    .background(.clear)
                    .shadow(radius: 10)
                    .onAppear {
                    }
            }
    }
}
