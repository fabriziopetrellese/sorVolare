//
//  DateModal.swift
//  sorVolare
//
//  Created by Fabrizio Petrellese on 30/10/24.
//

import Foundation
import SwiftUI


struct DateModal: View {
    
    @Environment(\.dismiss) var done
    @Binding var selectedDate: Date //collegare con la @State
    
    
    var body: some View {
        NavigationStack {
            VStack {
                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                
                Spacer()
            }
            .navigationTitle("Select Date")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Done") {
                done()
            })
        }
    }
}


#Preview {
    DateModal(selectedDate: .constant(Date()))
}
