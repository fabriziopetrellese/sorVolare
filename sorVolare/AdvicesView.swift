//
//  AdviceView.swift
//  sorVolare
//
//  Created by Fabrizio Petrellese on 25/10/24.
//

import SwiftUI

struct AdvicesView: View {
    @Binding var consigli: [Consiglio]
    
    var body: some View {
        
        NavigationStack {
            List{
                ForEach($consigli, id: \.id) { $consiglio in
                    
                    HStack(alignment: .top, spacing: 15){
                        Image(consiglio.file)
                            .resizable()
                            .scaledToFill()
                        //.cornerRadius(10)
                            .frame(width: 135, height: 90)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(consiglio.title)
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            Text("consiglio.description")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .lineLimit(2) //Limita a due righe
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color(.systemGray6).opacity(0.3)).stroke(.gray, lineWidth: 0.1))
                    .shadow(color: Color.black.opacity(0.015), radius: 4, x: 0, y: 2)
                    
                }//ForEach
            }//List
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Advices")
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
    AdvicesView(consigli: .constant([Consiglio(title: "Consiglio 1",file: "iphone180"),Consiglio(title: "Consiglio 2",file: "airport"),Consiglio(title: "Consiglio 3",file: "durante"),Consiglio(title: "Consiglio 4",file: "turbo"),Consiglio(title: "Consiglio",file: "landing"),Consiglio(title: "Consiglio 5",file: "DECOLLO")]))
}
