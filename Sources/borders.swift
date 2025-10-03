import SwiftUI
import Foundation

struct BorderView: View {
    @State var winList: [Window] = getWindows()
    var body: some View {
        var winCount = winList.count
        // ForEach(0..<winCount) { window in winList
            Rectangle()
                // .frame(maxWidth: window.width)
                // .frame(maxHeight: window.height)
                .background(.clear)
                .border(.white)
                .shadow(radius: 10)
                .onAppear {
                    print(winList as Any)
                }
        // }
    }
}
