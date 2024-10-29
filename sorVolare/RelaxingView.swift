//
//  AdviceView.swift
//  sorVolare
//
//  Created by Fabrizio Petrellese on 25/10/24.
//

import SwiftUI

struct RelaxingView: View {
    //@Binding var consigli: [Consiglio]
    
    var body: some View {
        
        
        
        
        
        NavigationStack {
           // List {
            VStack(spacing: 35) {
                    
                    
                    
                    //Text("Qui va del testo che spiega quello che fa quetsa view")
                    
                    
                    
                    
                    
                    // Navigation Link to Cognitive Behavioral
                    NavigationLink(destination: CognitiveBehavioralView()) {
                        
                        HStack(spacing: 15) {
                            Image("Immagine")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 135, height: 90)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                            
                            Text("Cognitive Behavioral")
                                .font(.headline)
                                .foregroundColor(.primary)
                            Spacer()
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color(.systemGray6).opacity(0.3)).stroke(.gray, lineWidth: 0.1))
                        .shadow(color: Color.black.opacity(0.015), radius: 4, x: 0, y: 2)
                        
                    }
                    
                    
                    
                    
                    // Navigation Link to Cognitive Behavioral
                    NavigationLink(destination: AutogenicTrainingView()) {
                        
                        HStack(spacing: 15) {
                            Image("Immagine")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 135, height: 90)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                            
                            Text("Autogenic Training")
                                .font(.headline)
                                .foregroundColor(.primary)
                            Spacer()
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color(.systemGray6).opacity(0.3)).stroke(.gray, lineWidth: 0.1))
                        .shadow(color: Color.black.opacity(0.015), radius: 4, x: 0, y: 2)
                        
                    }
                    
                    
                    
                    // Navigation Link to Cognitive Behavioral
                    NavigationLink(destination: SelfAwarenessView()) {
                        
                        HStack(spacing: 15) {
                            Image("Immagine")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 135, height: 90)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                            
                            Text("Self Awareness")
                                .font(.headline)
                                .foregroundColor(.primary)
                            Spacer()
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color(.systemGray6).opacity(0.3)).stroke(.gray, lineWidth: 0.1))
                        .shadow(color: Color.black.opacity(0.015), radius: 4, x: 0, y: 2)
                        
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
            
                    
                    /*
                    HStack(spacing: 15) {
                        Image("Immagine")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 135, height: 90)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                        
                        Text("Testo")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color(.systemGray6).opacity(0.3)).stroke(.gray, lineWidth: 0.1))
                    .shadow(color: Color.black.opacity(0.015), radius: 4, x: 0, y: 2)
                    */
                    
                    
                    
                    
                }
            //}
            //.listStyle(InsetGroupedListStyle())
            .navigationTitle("Relaxing")
            .navigationBarTitleDisplayMode(.large)
            
        }
        //.scrollContentBackground(.hidden)
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        /*
         NavigationStack {
         List{
         ForEach($consigli, id: \.id) { $consiglio in
         
         NavigationLink(destination: DetailView(consiglio: consiglio)) {
         HStack(spacing: 16){
         Image(consiglio.file)
         .resizable()
         .aspectRatio(contentMode: .fill)
         .frame(width: 80, height: 80)
         .cornerRadius(15)
         .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
         
         VStack(alignment: .leading, spacing: 5) {
         Text(consiglio.title.uppercased())
         .font(.headline)
         .foregroundColor(.primary)
         
         Text("consiglio.description")
         .font(.system(size: 14))
         .foregroundColor(.secondary)
         .lineLimit(3)
         }
         }
         .padding(.vertical, 8)
         
         }
         
         }//ForEach
         .listRowBackground(Color.clear) // Rende lo sfondo della riga trasparente
         }//List
         .listStyle(PlainListStyle())
         .navigationTitle("Advices")
         .navigationBarTitleDisplayMode(.large)
         }
         //.scrollContentBackground(.hidden)
         */
    }
    
}

/*func deleteItem(offsets: IndexSet) {
 photos.remove(atOffsets: offsets)
 save()
 }
 */


#Preview {
    //AdvicesView(consigli: .constant([Consiglio(title: "Consiglio 1",file: "iphone180", description: ""),Consiglio(title: "Consiglio 2",file: "airport", description: ""),Consiglio(title: "Consiglio 3",file: "durante", description: ""),Consiglio(title: "Consiglio 4",file: "turbo", description: ""),Consiglio(title: "Consiglio 5",file: "landing", description: ""),Consiglio(title: "Consiglio 6",file: "DECOLLO", description: "")]))
}
