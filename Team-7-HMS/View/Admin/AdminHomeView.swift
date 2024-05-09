import SwiftUI

struct AdminHomeView: View {
    @State private var selectedTab: Int = 0 // State to control the selected tab
    @State private var bounce: Bool = false // State to control the bounce effect

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                VStack(spacing: 0) {
                    switch selectedTab {
                    case 0:
                        AdminDashboard()
                    case 1:
                        AddingSlots()
                    case 2:
                        AddDoctorDetails()
                    case 3:
                        AdminLeaveViewPageView()
                    default:
                        Text("Selection does not exist")
                    }
                }
                .frame(maxWidth: .infinity)
                
                // Custom Tab Bar
                HStack {
                    ForEach(0..<4, id: \.self) { index in
                        Button(action: {
                            selectedTab = index
                            bounce = true
                            DispatchQueue.main.asyncAfter(deadline: .now()) {
                                bounce = false
                            }
                        }) {
                            VStack {
                                Image(systemName: iconName(for: index))
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(index == selectedTab ? Color.accentColor : Color.gray, Color.gray.opacity(0.5))
                                    .scaleEffect(bounce && index == selectedTab ? 2.2 : 1.6) // Apply scale effect
                                    .padding(.vertical, index == selectedTab ? 3 : 2)
                                Text(iconLabel(for: index))
                                    .font(.caption)
                                    .foregroundColor(index == selectedTab ? .accentColor : .gray)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .frame(height: 70)
                .padding(.top, 10)
                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0)
                .background {
                    BlurView(style: .regular)
                        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 2)
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    func iconName(for index: Int) -> String {
        switch index {
        case 0: return "chart.bar.doc.horizontal.fill"
        case 1: return "calendar"
        case 2: return "stethoscope"
        case 3: return "airplane.departure"
        default: return ""
        }
    }
    
    func iconLabel(for index: Int) -> String {
        switch index {
        case 0: return "Dashboard"
        case 1: return "Add Slots"
        case 2: return "Add Doctors"
        case 3: return "Leave"
        default: return ""
        }
    }
}

// Dummy views and preview for compilation
// Add your existing dummy views and preview code here

// Preview struct
struct AdminHomeView_Previews: PreviewProvider {
    static var previews: some View {
        AdminHomeView()
    }
}
