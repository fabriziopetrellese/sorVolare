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
    @State private var consigli = [Consiglio(title: "Consiglio 1", file: "iphone180"), Consiglio(title: "Consiglio 2", file: "airport"), Consiglio(title: "Consiglio 3", file: "durante"), Consiglio(title: "Consiglio 4", file: "turbo"), Consiglio(title: "Consiglio 5", file: "landing"), Consiglio(title: "Consiglio 6", file: "DECOLLO")]
    @State private var steps = [Step(title: "step 1", file: "checkin"), Step(title: "step 2", file: "entrata"), Step(title: "step 3", file: "deco"), Step(title: "step 4", file: "atter"), Step(title: "step 5", file: "")]
    
    
    var body: some View {
        
        TabView(selection: $selection) {
            
            FirstView()
                .tabItem {
                    Label("Avvio", systemImage: "airplane.departure")
                        .accentColor(.primary)
                }.tag(0)
            
            AdvicesView(consigli: $consigli)
                .tabItem {
                    Label("Advices", systemImage: "lightbulb.fill").font(.system(size: 10))
                        .accentColor(.primary)
                }
                .tag(1)
            
            StepsView(steps: $steps)
                .tabItem {
                    Label("Steps", systemImage: "list.number")
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
