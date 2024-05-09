//import SwiftUI
//import UIKit
//
//struct BlurView: UIViewRepresentable {
//    var style: UIBlurEffect.Style
//
//    func makeUIView(context: Context) -> UIVisualEffectView {
//        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
//        return view
//    }
//
//    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
//        uiView.effect = UIBlurEffect(style: style)
//    }
//}
//
//struct PatientView: View {
//    @State private var selectedTab: Int = 0
//    @State var patientName: String
//    @State var showPatientHistory: Bool = false
//    @State var patientUid: String
//    
//    var body: some View {
//        // Use a ZStack to overlay the tab bar on top of the content
//        ZStack(alignment: .bottom) {
//            // Main content view
//            ScrollView {
//                VStack(spacing: 0) {
//                    switch selectedTab {
//                    case 0:
//                        patientHomeSwiftUIView(patientUID: patientUid, userName: patientName)
//                    case 1:
//                        BookingView(patientID: patientUid)
//                    case 2:
//                        PatientMedicalRecordView()
//                    case 3:
//                        PatientAppointmentView()
//                    default:
//                        Text("Selection does not exist")
//                    }
//                }
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            
//            // Custom Tab Bar with transparent background and blur effect
//            // Use a ZStack to apply the shadow to the BlurView
//            ZStack {
//                // Shadow layer
//                Color.clear // Use a clear color for the shadow layer
//                    .frame(height: 50) // Match the height of the tab bar
//                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 2) // Apply the shadow here
//                
//                // BlurView layer
//                HStack {
//                    ForEach(0..<4, id: \.self) { index in
//                        Button(action: {
//                            withAnimation(.easeInOut) {
//                                selectedTab = index
//                            }
//                        }) {
//                            VStack {
//                                Image(systemName: iconName(for: index))
//                                    .symbolRenderingMode(.palette)
//                                    .foregroundStyle(index == selectedTab ? Color.blue : Color.gray, Color.gray.opacity(0.5))
//                                    .scaleEffect(1.6)
//                                    .padding(.vertical, index == selectedTab ? 5 : 0)
//                            }
//                        }
//                        .frame(maxWidth: .infinity)
//                    }
//                }
//                .frame(height: 50) // Set a constant height for the tab bar
//                .padding(.top, 10)
//                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
//                .background(BlurView(style: .systemMaterial)) // Apply the blur effect here
//            }
//        }
//        .edgesIgnoringSafeArea(.bottom) // Ensures the tab bar extends into the safe area
//        .sheet(isPresented: $showPatientHistory, content: {
//            PatientHistory(isPresented: $showPatientHistory, uid: patientUid)
//        })
//    }
//    
//    func iconName(for index: Int) -> String {
//        switch index {
//        case 0: return "house.fill"
//        case 1: return "plus"
//        case 2: return "doc.fill"
//        case 3: return "calendar"
//        default: return ""
//        }
//    }
//}
//
//// Dummy views and preview for compilation
//// Add your existing dummy views and preview code here
//
//// Preview struct
//struct PatientView_Previews: PreviewProvider {
//    static var previews: some View {
//        PatientView(patientName: "Luigi", showPatientHistory: false, patientUid: "hi")
//    }
//}
