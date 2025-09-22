import SwiftUI
import Foundation

func testFunc() {
}

struct BorderView: View {
        // var windowList: CFArray?
    var body: some View {
            // ForEach(0..<winCount) { window in windowList
                Rectangle()
                    .frame(maxWidth: 240)
                    .frame(maxHeight: 150)
                    .background(.clear)
                    .border(.white)
                    .shadow(radius: 10)
                    .onAppear {
                        testFunc()
                        test()
                    }
                // }
    }
}
