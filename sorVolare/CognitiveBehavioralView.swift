//
//  CognitiveBehavioralView.swift
//  sorVolare
//
//  Created by Tulli-OS on 28/10/24.
//

import SwiftUI

struct CognitiveBehavioralView: View {
    
    @State private var sq = [
        squareButton(nome: "Nome Gioco 1", colore: .red),
        squareButton(nome: "Nome Gioco 2", colore: .yellow),
        squareButton(nome: "Nome Gioco 3", colore: .blue),
        squareButton(nome: "Nome Gioco 4", colore: .green),
        squareButton(nome: "Nome Gioco 5", colore: .brown),
        squareButton(nome: "Nome Gioco 6", colore: .pink)
    ]
    
    
    
    //let buttons = ["Button 1", "Button 2", "Button 3", "Button 4", "Button 5", "Button 6"]
    
    
    //squareButton(nome: "Nome Gioco 1", colore: .red)
    //squareButton(nome: "Nome Gioco 2", colore: .green)
    
    
    var body: some View {
            
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
            //GridItem(.adaptive(minimum: 80)),
        ]
        
        
        
        VStack {
                    Text("Let's play !!!")
                        .font(.title)
                        .padding()

            
            
            
            
            // Navigation Link to BabyToy Game
            NavigationLink(destination: BabyToyView()) {
                
                HStack(spacing: 15) {
                    //Image("Immagine")
                     //   .resizable()
                     //   .scaledToFill()
                     //   .frame(width: 135, height: 90)
                     //   .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                    
                    Text("Mini Balls")
                        .frame(minWidth: 100, minHeight: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                //.background(RoundedRectangle(cornerRadius: 15).fill(Color(.systemGray6).opacity(0.3)).stroke(.gray, lineWidth: 0.1))
                //.shadow(color: Color.black.opacity(0.015), radius: 4, x: 0, y: 2)
                
            }
            
            // Navigation Link to Puzzle Game
            NavigationLink(destination: PuzzleView()) {
                
                HStack(spacing: 15) {
                    //Image("Immagine")
                     //   .resizable()
                     //   .scaledToFill()
                     //   .frame(width: 135, height: 90)
                     //   .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                    
                    Text("Puzzle")
                        .frame(minWidth: 100, minHeight: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                //.background(RoundedRectangle(cornerRadius: 15).fill(Color(.systemGray6).opacity(0.3)).stroke(.gray, lineWidth: 0.1))
                //.shadow(color: Color.black.opacity(0.015), radius: 4, x: 0, y: 2)
                
            }
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            /*
                    LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
                        ForEach(sq, id: \.id) { buttonTitle in
                            
                                // Azione da eseguire quando il bottone viene premuto
                                //print("\(buttonTitle) premuto!")
                                
                                
                                // Navigation Link to Cognitive Behavioral
                                NavigationLink(destination: BabyToyView()) {
                                    
                                    HStack(spacing: 15) {
                                        //Image("Immagine")
                                         //   .resizable()
                                         //   .scaledToFill()
                                         //   .frame(width: 135, height: 90)
                                         //   .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                                        
                                        Text(buttonTitle.nome)
                                            .frame(minWidth: 100, minHeight: 50)
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                            .cornerRadius(10)
                                    }
                                    .padding()
                                    //.background(RoundedRectangle(cornerRadius: 15).fill(Color(.systemGray6).opacity(0.3)).stroke(.gray, lineWidth: 0.1))
                                    //.shadow(color: Color.black.opacity(0.015), radius: 4, x: 0, y: 2)
                                    
                                }
                                
                                
                            
                        }
                    }
                    .padding()
            
            
            */
            
            
            
            
            
            
            
            
            
            
            
            
            
                }
        
    }
    
    
    
    
    
    //PuzzleView()
    
    
    
    
    
    
    
    
    /*
    let rows = [
        GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80))
    ]
    
    @State private var sq = [
        squareButton(nome: "Nome Gioco 1", colore: .red),
        squareButton(nome: "Nome Gioco 2", colore: .yellow),
        squareButton(nome: "Nome Gioco 3", colore: .blue),
        squareButton(nome: "Nome Gioco 4", colore: .green),
        squareButton(nome: "Nome Gioco 5", colore: .brown),
        squareButton(nome: "Nome Gioco 6", colore: .pink)
    ]
    
    var body: some View {
        
        
        
        HStack {
        GeometryReader { geometry in
            
            
            
            //ScrollView(.horizontal) {
            LazyHGrid(rows: rows, alignment: .center) {
                ForEach(sq, id: \.id) { item in
                    //Text("yooooo")
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue)
                    
                        .frame(width: geometry.size.width * 0.20, height: geometry.size.height * 0.20)
                        
                    //    Image(systemName: "\(item).circle.fill")
                    //        .font(.largeTitle)
                    
                    
                }
            }
            
        }
        }
        
        
        
        
        
        */
    }
    
    
    
    
    
    
    
    
    
    
    


#Preview {
    CognitiveBehavioralView()
}


struct squareButton {
    var id = UUID()
    var nome: String
    var colore: Color
}
