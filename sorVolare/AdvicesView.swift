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
                    
                    HStack{
                        Image(consiglio.file)
                            .resizable()
                            .cornerRadius(10)
                            .frame(width: 110, height: 110)
                        Text(consiglio.title)
                    }
                    
                }//ForEach
            }//List
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
