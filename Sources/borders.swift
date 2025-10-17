import SwiftUI
import Foundation

struct BorderView: View {
    @State private var winList: [Window] = getWindows()
    var body: some View {
        ZStack {
            ForEach(winList, id: \.pid) { window in
                Rectangle()
                    .frame(maxWidth: window.bounds.width)
                    .frame(maxHeight: window.bounds.height)
                    .background(.clear)
                    .position(x: window.bounds.midX,
                              y: window.bounds.midY)
                    .border(.white)
                    .shadow(radius: 10)
                    .onAppear {
                        print(winList as Any)
                    }
            }
        }
    }
}
