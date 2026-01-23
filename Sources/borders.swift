import Foundation
import SwiftUI

struct BorderView: View {
    let config: BorderConfig
    init(config: BorderConfig) { self.config = config }
    @StateObject private var observer = WindowObserver()
    var body: some View {
        GeometryReader { geo in
            ForEach(observer.winList, id: \.windowNumber) { window in
                let borderColour =
                    window.windowNumber == observer.activeWin?.windowNumber
                    ? config.activeColor : config.inactiveColor
                RoundedRectangle(cornerRadius: config.cornerRadius)
                    .stroke(borderColour, lineWidth: config.borderWidth)
                    .frame(width: window.bounds.width + 1)
                    .frame(height: window.bounds.height + 1)
                    .position(
                        x: window.bounds.midX - 1,
                        y: window.bounds.midY - 1
                    )
                    .background(.clear)
                    .shadow(radius: config.shadowRadius)
            }
        }
    }
}
