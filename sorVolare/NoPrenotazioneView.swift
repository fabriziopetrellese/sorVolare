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
            
            Text("Non hai prenotato il volo perchè ti spaventa qualcosa?")
            
            NavigationLink(destination: NoPauraView()) {
                Text("No")
                
            }
            
            NavigationLink(destination: YesFearToFlightView()) {
                Text("Si")
                
            }
        }
        
    }
}

#Preview {
    NoPrenotazioneView()
}
