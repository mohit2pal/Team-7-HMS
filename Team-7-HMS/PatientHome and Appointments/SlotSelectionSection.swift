import SwiftUI

struct SlotSelectionSection: View {
    @Binding var slotDetails: [String: Any]?
    @Binding var selectedSlot: String?
    var doctorId: String
    @Binding var complaints: [String]
    @Binding var newComplaint: String

    var body: some View {
        VStack {
            if let slotDetails = slotDetails as? [String: [[String: String]]], !slotDetails.isEmpty {
                ForEach(slotDetails.sorted(by: { $0.key < $1.key }), id: \.key) { date, slots in
                    Section(header: Text("Available Slots on \(date.replacingOccurrences(of: "_", with: "-"))")) {
                        LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 10) {
                            ForEach(slots, id: \.self) { slot in
                                let time = slot.keys.first ?? ""
                                Button(action: {
                                    // Handle slot selection
                                    self.selectedSlot = time
                                }) {
                                    Text(time)
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .padding()
                                        .background(Date() > getDateLiteral(date: date, time: time) ? Color.gray : slotColor(slot: slot))
                                        .cornerRadius(15)
                                        .foregroundColor(Date() > getDateLiteral(date: date, time: time) ? Color.white : Color.black)
                                        .disabled(Date() > getDateLiteral(date: date, time: time))
                                }
                            }
                        }
                    }
                }
            // Complaints list and input
                VStack(alignment: .leading) {
                    Text("Symptoms")
                        .font(.title2)
                        .bold()
                    List{
                        ForEach(complaints, id: \.self) { complaint in
                            HStack {
                                Text(complaint)
                                Spacer()
                                Button(action: {
                                    // Action to delete complaint
                                    if let index = complaints.firstIndex(of: complaint) {
                                        complaints.remove(at: index)
                                    }
                                }, label: {
                                    Image(systemName: "trash")
                                })
                            }
                        }
                        .onDelete(perform: deleteComplaints)
                    }
                    .listStyle(PlainListStyle())
                    .background(Color.background)
                    .frame(height: complaints.isEmpty ? 0 : CGFloat(complaints.count * 50))
                    HStack {
                        TextField("Add Complaint", text: $newComplaint)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .customShadow()
                        Button(action: {
                            // Action to add complaint
                            complaints.append(newComplaint)
                            newComplaint = ""
                        }, label: {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.blue)
                                .font(.title3)
                        })
                    }
                }
            }  else {
                Text("No slots available")
                    .padding()
            }
        }
    }
    
    private func deleteComplaints(at offsets: IndexSet) {
        complaints.remove(atOffsets: offsets)
    }
    
    private func slotColor(slot: [String: String]) -> Color {
        let time = slot.keys.first ?? ""
        return time == selectedSlot ? Color.blue : Color.gray.opacity(0.2)
    }
}
