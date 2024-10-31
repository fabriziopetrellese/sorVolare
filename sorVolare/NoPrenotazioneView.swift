//
//  NoBookedFlightView.swift
//  sorVolare
//
//  Created by Tulli-OS on 29/10/24.
//

import SwiftUI

struct NoPrenotazioneView: View {
    
    
    @State private var showModal = false
    @State private var showModal1 = false
    @State private var showModal2 = false
    @State private var showModal3 = false
    var body:some View {
        VStack {
            Text("Se tra queste ci sono delle tue paure cliccaci sopra per informarti")
                .padding()
            header
                .background{
                    RoundedRectangle(cornerRadius: 200)
                        .foregroundColor(.white)
                        
                }
                .frame(width:100 , height: 30)
            header1
                .background{
                    RoundedRectangle(cornerRadius: 200)
                        .foregroundColor(.white)
                        
                }
                .frame(width:200 , height: 30)
            header2
                .background{
                    RoundedRectangle(cornerRadius: 200)
                        .foregroundColor(.white)
                        
                }
                .frame(width:100 , height: 30)
            header3
                .background{
                    RoundedRectangle(cornerRadius: 200)
                        .foregroundColor(.white)
                        
                }
                .frame(width:100 , height: 30)
        }
        
    }
    
    
    
    
    
    var header: some View {
        VStack {
            
            Button("Turbolence.") {
                showModal = true
                    
            }
            .foregroundStyle(.blue)
            
        }
        .sheet(isPresented: $showModal) {
            // La vista del modale
            MotivoPaura1View(showModal: $showModal)
        }
    }
        
            
            
            /*NavigationLink(destination: MotivoPaura1View()) {
                Image("turbo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100,alignment: .leading)
                Text("Turbolenze")
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .frame(width: 100, height: 100,alignment: .leading)
                
                
                
            }*/
            
            
        
       
        
    
    var header1:some View{
        
        
        VStack {
            Button("Malfunzionamento.") {
                showModal1 = true
            }
            .foregroundStyle(.blue)
            .background{
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(.white)
            }
        }
        .sheet(isPresented: $showModal1) {
            // La vista del modale
            MotivoPaura2View(showModal1: $showModal1)
        }
    }
    
    var header2:some View{
        
        
        VStack {
            Button("Attacchi.") {
                showModal2 = true
            }
            .foregroundStyle(.blue)
            .background{
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(.white)
            }
        }
        .sheet(isPresented: $showModal2) {
            // La vista del modale
            MotivoPaura3View(showModal2: $showModal2)
        }
        
    }
    var header3:some View{
        
        
        VStack {
            Button("Morte.") {
                showModal3 = true
            }
            .foregroundStyle(.blue)
            .background{
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(.white)
            }
        }
        .sheet(isPresented: $showModal3) {
            // La vista del modale
            MotivoPaura4View(showModal3: $showModal3)
        }
       
    }
}
#Preview {
    NoPrenotazioneView()
}
