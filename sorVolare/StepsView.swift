//
//  StepView.swift
//  sorVolare
//
//  Created by Fabrizio Petrellese on 25/10/24.
//

import SwiftUI

struct StepsView: View {
    @Binding var steps: [Step]
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach($steps, id: \.id) { $step in
                    
                    HStack(spacing: 15) {
                        Image(step.file)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 135, height: 90)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                        
                        Text(step.title.uppercased())
                            .font(.headline)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color(.systemGray6).opacity(0.3)).stroke(.gray, lineWidth: 0.1))
                    .shadow(color: Color.black.opacity(0.015), radius: 4, x: 0, y: 2)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Steps")
            .navigationBarTitleDisplayMode(.large)
        }
        //.scrollContentBackground(.hidden)
        
    }
}

/*func deleteItem(offsets: IndexSet) {
 photos.remove(atOffsets: offsets)
 save()
 }
 */


#Preview {
    StepsView(steps: .constant([Step(title:"Step 1", file: "entrata"), Step(title:"Step 2", file: "checkin"), Step(title:"Step 3", file: "deco"), Step(title:"Step 4", file: "atter"), Step(title:"Step 5", file: "uscita")]))
}
