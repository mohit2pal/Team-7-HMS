import SwiftUI

struct DoctorView: View {
    @State private var selectedTab: Int = 0 // State to control the selected tab
    @State var doctorUid: String
    @State var doctorDetails: DoctorDetails
    @State var doctorName: String
    @State private var bounce: Bool = false // State to control the bounce effect

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                switch selectedTab {
                case 0:
                    DoctorHomeSwiftUI(doctorUid: doctorUid, doctor: doctorDetails, doctorName: doctorName)
                case 1:
                    ReportsListView()
                case 2:
                    leaveRequestPicker(doctor: doctorDetails, doctorUid: doctorUid)
                default:
                    Text("Selection does not exist")
                }
            }
            .frame(maxWidth: .infinity)
            
            // Custom Tab Bar
            HStack {
                ForEach(0..<3, id: \.self) { index in
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
                            Text(iconLabel(for: index)) // Add this line to include text
                                .font(.caption)
                                .foregroundColor(index == selectedTab ? .accentColor : .gray)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .frame(height: 70)
            .padding(.top, 10)
            .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            .background {
                BlurView(style: .regular)
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 2)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    func iconName(for index: Int) -> String {
        switch index {
        case 0: return "house.fill"
        case 1: return "doc.text.image"
        case 2: return "airplane.departure"
        default: return ""
        }
    }
    func iconLabel(for index: Int) -> String {
        switch index {
        case 0: return "Home"
        case 1: return "Reports"
        case 2: return "Leave Request"
        default: return ""
        }
    }
}

// Dummy views, DoctorDetails struct, and preview for compilation
// Add your existing dummy views, DoctorDetails struct, and preview code here

// Preview struct
struct DoctorView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorView(doctorUid: "hi", doctorDetails: DoctorDetails(dictionary: mockDoctorData)!, doctorName: "Harish")
    }
}
