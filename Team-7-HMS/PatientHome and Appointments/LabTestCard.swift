//
//  LabTestCard.swift
//  Team-7-HMS
//
//  Created by Ekta on 03/05/24.
//

import SwiftUI

struct LabTestCard: View {
  var labTestData: LabTestCardData

  var body: some View {
    HStack {
      VStack {
        Text("\(labTestData.date)")
          .font(CentFont.mediumBold)
        Text(labTestData.day)
          .font(CentFont.smallReg)
      }
      .foregroundColor(.white)
      .padding()
      .frame(width: 70, height: 70)
      .background(Color.myAccent)
      .cornerRadius(50)

      Spacer()
        .frame(width: 30)
      VStack(alignment: .leading) {
        Text(labTestData.testName)
          .font(CentFont.mediumReg)
        Text(labTestData.doctorName)
          .font(.system(size: 23, weight: .semibold))
      }

      Spacer()

        Image(systemName: "square.and.arrow.down")
    }
    .padding()
//    .padding(.vertical, 10) // Uncomment for vertical padding
    .background(Color.white)
    .cornerRadius(28)
    .customShadow()
  }
}

#Preview {
  LabTestCard(labTestData: LabTestMockData.labTestDataArray[0])
}
