import SwiftUI

final class BorderConfig: ObservableObject {
    @Published var enabledState: Bool
    @Published var activeColor: Color
    @Published var inactiveColor: Color
    @Published var borderWidth: CGFloat
    @Published var cornerRadius: CGFloat
    @Published var shadowEnabled: Bool
    @Published var shadowRadius: CGFloat
    @Published var padding: CGFloat

    init(
        enabled: Bool = true,
        active: Color = .blue,
        inactive: Color = .gray
    ) {
        self.enabledState = enabled
        self.activeColor = Color(active)
        self.inactiveColor = Color(inactive)
        self.borderWidth = 1
        self.cornerRadius = 0
        self.shadowEnabled = true
        self.shadowRadius = 0
        self.padding = 0
    }
    static let updateNotification = Notification.Name("com.fejiroe.swiftborders.update")

    func apply(_ dict: [String: Any]) {
        if let enabled = dict["enableBorders"] as? Bool {
            self.enabledState = enabled
        }
        if let active = dict["activeColor"] as? String {
            self.activeColor = Color(active)
        }
        if let inactive = dict["inactiveColor"] as? String {
            self.inactiveColor = Color(inactive)
        }
        if let borderWidth = dict["borderWidth"] as? CGFloat {
            self.borderWidth = borderWidth
        }
    }
}
