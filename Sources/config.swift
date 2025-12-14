import SwiftUI

final class BorderConfig: ObservableObject {
    @Published var enabledState: Bool
    @Published var activeColor: Color
    @Published var inactiveColor: Color
    @Published var shadowEnabled: Bool
    @Published var borderWidth: CGFloat
    @Published var cornerRadius: CGFloat
    @Published var shadowRadius: CGFloat

    init(enabled: Bool = true,
         activeHex: Color = .red,
         inactiveHex: Color = .white) {
             self.enabledState = enabled
             self.activeColor = Color(activeHex)
             self.inactiveColor = Color(inactiveHex)
             self.shadowEnabled = true
             self.borderWidth = 1
             self.cornerRadius = 0
             self.shadowRadius = 0
        }
    static let updateNotification = Notification.Name("com.fejiroe.swiftborders.update")

    func apply(_ dict: [String: Any]) {
        if let enabled = dict["enableBorders"] as? Bool {
            self.enabledState = enabled}
        if let active = dict["activeColor"] as? String {
            self.activeColor = Color(active)}
        if let inactive = dict["inactiveColor"] as? String {
            self.inactiveColor = Color(inactive)}
    }
}
