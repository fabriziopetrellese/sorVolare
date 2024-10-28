//
//  ContentView.swift
//  sorVolare
//
//  Created by Fabrizio Petrellese on 20/10/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @State private var selection: Int = 0
    @State private var consigli = [Consiglio(title: "Consiglio 1", file: "iphone180", description: "descrizione consiglio 1"), Consiglio(title: "Consiglio 2", file: "airport", description: "descrizione consiglio 2"), Consiglio(title: "Consiglio 3", file: "durante", description: "descrizione consiglio 3"), Consiglio(title: "Consiglio 4", file: "turbo", description: "descrizione consiglio 4"), Consiglio(title: "Consiglio 5", file: "landing", description: "descrizione consiglio 5"), Consiglio(title: "Consiglio 6", file: "DECOLLO", description: "descrizione consiglio 6")]
    @State private var steps = [Step(title: "rullaggio", file: "checkin"), Step(title: "decollo", file: "entrata"), Step(title: "atterraggio", file: "deco"), Step(title: "turbolenze", file: "atter"), Step(title: "step 5", file: "")]
    
    
    var body: some View {
        
        TabView(selection: $selection) {
            
            FirstView()
                .tabItem {
                    Label("Simulation", systemImage: "airplane.departure")
                        .accentColor(.primary)
                }.tag(0)
            
//            AdvicesView(consigli: $consigli)
                AdvicesView()
                .tabItem {
                    Label("Relaxing", systemImage: "lightbulb.fill").font(.system(size: 10))
                        .accentColor(.primary)
                }
                .tag(1)
            
            StepsView(steps: $steps)
                .tabItem {
                    Label("Progress", systemImage: "list.number")
                        .accentColor(.primary)
                }
        }//TabView
        
    } //body
    
}//ContentView


// Pickers
/*
 VStack(spacing: 20) {
 HStack {
 Text("Fly from:")
 .font(.title3)
 .padding(.leading)
 
 Picker("Select", selection: $flyFromSelection) {
 ForEach(locations) { location in
 Text(location.capitale)
 .tag(location as Location?)
 }
 }.pickerStyle(.automatic)
 
 Spacer()
 }
 
 HStack {
 Text("Fly to:")
 .font(.title3)
 .padding(.leading)
 
 Picker("Select", selection: $flyToSelection) {
 ForEach(locations) { location in
 Text(location.capitale)
 .tag(location as Location?)
 }
 
 }.pickerStyle(.automatic)
 
 Spacer()
 }
 }
 .padding()
 */


#Preview {
    ContentView()
}
