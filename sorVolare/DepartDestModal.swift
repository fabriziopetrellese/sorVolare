//
//  DepartDestModal.swift
//  sorVolare
//
//  Created by Fabrizio Petrellese on 30/10/24.
//

import SwiftUI
struct DepartDestModal: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedLocation: Location?
    var locations: [Location]
    
    
    var body: some View {
        NavigationView {
            List(locations, id: \.id) { location in
                Button(action: {
                    selectedLocation = location
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text(location.capitale)
                        .font(.system(size: 18, weight: .light))
                        .foregroundColor(.blue)
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(8) // Raggio per arrotondare gli angoli
                }
            }
            .navigationTitle(Text("Select city"))
            .navigationBarItems(trailing: Button("Close") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

#Preview {
    DepartDestModal(selectedLocation: .constant(nil), locations: [])
}
