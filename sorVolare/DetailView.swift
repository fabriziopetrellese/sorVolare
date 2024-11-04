//
//  DetailView.swift
//  sorVolare
//
//  Created by Federico Iermano on 04/11/24.
//
import SwiftUI

struct DetailView: View {
    @Binding var photo: Photo
    @Binding var photos: [Photo]
    
    var body: some View {
        ZStack {
            // Sfondo a schermo intero
            Image("sfondo")
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                Text(photo.description)
                    .foregroundColor(.black)
                    .padding()
            }
            .padding(.top, 70)
            .toolbar {
                // Aggiungi un titolo personalizzato nella barra di navigazione
                ToolbarItem(placement: .principal) {
                    Text(photo.title)
                        .foregroundColor(.black) // Imposta il colore del titolo su verde
                        .font(.headline)
                }
            }
        }
        .preferredColorScheme(.light)
    }
}


#Preview {
    //DetailView()
}
