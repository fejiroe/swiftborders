import SwiftUI
import Foundation

struct BorderView: View {
    @State var winList: [Window] = getWindows()
    var body: some View {
        var winCount = winList.count
        ZStack {
            ForEach(0..<winCount) { index in
                let window = winList[index]
                Rectangle()
                    .frame(maxWidth: window.bounds.width)
                    .frame(maxHeight: window.bounds.height)
                    .background(.clear)
                    .border(.white)
                    .shadow(radius: 10)
                    .onAppear {
                        print(winList as Any)
                    }
            }
        }
    }
}
