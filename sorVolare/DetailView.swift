//
//  DetailView.swift
//  sorVolare
//
//  Created by Fabrizio Petrellese on 25/10/24.
//


import SwiftUI

struct DetailView: View {
    var consiglio: Consiglio
    
    var body: some View {
        Text(consiglio.title)
        
        Text(consiglio.description)
        
    }//body
}





/*
 #Preview {
 DetailView()
 }
 */
