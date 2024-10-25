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
        
        NavigationStack{
            List{
                
                ForEach($steps, id: \.id) { $step in
                    NavigationLink(destination: DetailView(step: $step, steps: $steps)){
                        
                        HStack{
                            Image(step.file)
                                .resizable()
                                .cornerRadius(10)
                                .frame(width: 90, height: 90)
                            Text(step.title.uppercased())
                        }
                        
                    }
                }
                
            }
            //.onDelete(perform: deleteItem) vedere le slide
        }
        .navigationTitle("Step")
        .navigationBarTitleDisplayMode(.large)
        .scrollContentBackground(.hidden)
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
