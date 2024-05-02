// MARK: - DON'T REMOVE
//        VStack {
//
//                    // Date picker
//                    Spacer().frame(height: 30)
//                    HStack{
//                        Text("Select Date")
//                            .font(.headline)
//                        Spacer()
//                    }
//
//                    //DATES SCROLL
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack(spacing: 20) {
//                            ForEach(daysOfWeek, id: \.self) { date in
//                                DateButton(date: date, isSelected: date == selectedDate, action: {
//                                    selectedDate = date
//                                })
//                            }
//                        }
//                    }
//                    Spacer().frame(height: 30)
//                }
//                .background(
//                    Color.clear
//                        .contentShape(Rectangle())
//                )
//
//                // Display time slots when a doctor is selected
//                if let selectedDoctor = selectedDoctor {
//                    HStack{
//                        Text("Set time slots for")
//                        Text("\(selectedDoctor.name)")
//                            .foregroundStyle(.gray)
//                        Spacer()
//                    }
//                    .font(.headline)
//                    .padding(.vertical)
//
//
//                    // time slots
//                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 20) {
//                        ForEach(timeSlots, id: \.self) { slot in
//                            Button(action: {
//                                // Check if the slot is not booked before toggling the selection
//                                if !bookedSlots.contains(slot) {
//                                    // Toggle the selection of the time slot
//                                    if selectedSlots.contains(slot) {
//                                        selectedSlots.removeAll(where: { $0 == slot })
//                                    } else {
//                                        selectedSlots.append(slot)
//                                    }
//                                }
//                            }) {
//                                Text(slot)
//                                    .padding(.horizontal)
//                                    .padding(.vertical, 10)
//                                    .background(bookedSlots.contains(slot) ? Color.gray : (selectedSlots.contains(slot) ? Color.myAccent : Color.white))
//                                    .foregroundStyle(bookedSlots.contains(slot) ? Color.white : (selectedSlots.contains(slot) ? Color.white : Color.black))
//                                    .cornerRadius(8)
//                                    .customShadow()
//                                    .disabled(bookedSlots.contains(slot))
//                            }
//                            .frame(width: 180)
//                        }
//                    }
//                    .padding(.horizontal)
//                }
//            Spacer()
//            Button(action: {
//                // Action for the submit button
//                if let selectedDoctor = selectedDoctor {
//                    firebaseHelper.createSlots(doctorName: selectedDoctor.name, doctorID: selectedDoctor.id, date: selectedDate, slots: selectedSlots)
//                } else {
//                    print("No doctor selected.")
//                }
//            }, label: {
//                Text("Press here to submit")
//            })
//            .frame(width: 296, height: 44)
//            .background(isSubmitButtonDisabled ? Color.gray : Color.myAccent)
//            .foregroundColor(.white)
//            .cornerRadius(20)
//            .disabled(isSubmitButtonDisabled)
//        }
//        .padding()
//        .background(Color.background)
//        .onAppear {
//            // Fetch the list of doctors when the view appears
//            firebaseHelper.fetchAllDoctors { result in
//                switch result {
//                case .success(let doctors):
//                    self.doctors = doctors
//                case .failure(let error):
//                    print("Error fetching doctors: \(error.localizedDescription)")
//                }
//            }
//        }
//    }
//}
