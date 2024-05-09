import SwiftUI

struct PatientView: View {
    @State private var selectedTab: Int = 0
    @State var patientName: String
    @State var showPatientHistory: Bool = false
    @State var patientUid: String
    @State private var bounce: Bool = false // State to control the bounce effect

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                switch selectedTab {
                case 0:
                    patientHomeSwiftUIView(patientUID: patientUid, userName: patientName)
                case 1:
                    BookingView(patientID: patientUid)
                case 2:
                    PatientMedicalRecordView()
                case 3:
                    PatientAppointmentView()
                default:
                    Text("Selection does not exist")
                }
            }
            .frame(maxWidth: .infinity)
            
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
                                .foregroundStyle(index == selectedTab ? Color.accentColor : Color.gray, Color.gray.opacity(0.4))
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
            .frame(height: 70) // Adjusted to accommodate text
            .padding(.top, 10)
            .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            .background {
                BlurView(style: .regular)
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 2)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .sheet(isPresented: $showPatientHistory, content: {
            PatientHistory(isPresented: $showPatientHistory, uid: patientUid)
        })
    }
    
    func iconName(for index: Int) -> String {
        switch index {
        case 0: return "house.fill"
        case 1: return "plus.app"
        case 2: return "doc.fill"
        case 3: return "calendar"
        default: return ""
        }
    }
    func iconLabel(for index: Int) -> String {
        switch index {
        case 0: return "Home"
        case 1: return "Book"
        case 2: return "Records"
        case 3: return "Appointments"
        default: return ""
        }
    }
}

// Dummy views and preview for compilation
// Add your existing dummy views and preview code here

// Preview struct
struct PatientView_Previews: PreviewProvider {
    static var previews: some View {
        PatientView(patientName: "Luigi", showPatientHistory: false, patientUid: "hi")
    }
}
