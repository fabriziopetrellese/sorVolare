//
//  ContentView.swift
//  sorVolare
//
//  Created by Fabrizio Petrellese on 20/10/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        NavigationStack {
            
            Text("hai gia prenotato un volo?")
            
            NavigationLink(destination: NoPrenotazioneView()) {
                Text("No")
                
            }
            
            NavigationLink(destination: SiPrenotazioneView()) {
                Text("Si")
                
            }
        }
        
    } //body
    
}//ContentView



#Preview {
    ContentView()
}
