//
//  NoBookedFlightView.swift
//  sorVolare
//
//  Created by Tulli-OS on 29/10/24.
//

import SwiftUI

struct NoPrenotazioneView: View {
    var body: some View {
        
        
        NavigationStack {
            
            Text("Se tra queste ci sono delle tue paure informati cliccandoci sopra.")
            
            NavigationLink(destination: MotivoPaura1View()) {
                Text("Turbolenze")
                
            }
            
            NavigationLink(destination: MotivoPaura2View()) {
                Text("Malfuzionamento")
                
            }
            NavigationLink(destination: MotivoPaura3View()) {
                Text("Attacchi terroristici")
                
            }
            NavigationLink(destination: MotivoPaura4View()) {
                Text("Morte durante il volo")
                
            }
        }
        
    }
}

#Preview {
    NoPrenotazioneView()
}
