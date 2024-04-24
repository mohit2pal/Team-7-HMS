import SwiftUI

enum CentFont {
    static let largeSemiBold: Font = .system(size: 32, weight: .medium)
    static let mediumReg: Font = .system(size: 20, weight: .regular)
    static let mediumSemiBold: Font = .system(size: 20, weight: .semibold)
    static let mediumBold: Font = .system(size: 20, weight: .bold)
    static let smallReg: Font = .system(size: 17, weight: .regular)
    static let smallSemiBold: Font = .system(size: 17, weight: .semibold)
    static let actionButton: Font = Font.system(size: 15, weight: .regular) //action items
}

extension View {
    func customShadow() -> some View {
        self.shadow(color: Color(red: 0.486, green: 0.588, blue: 1, opacity: 0.05), radius: 20, x: 2, y: 0)
    }
}
