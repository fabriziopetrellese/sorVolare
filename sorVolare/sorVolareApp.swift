//
//  sorVolareApp.swift
//  sorVolare
//
//  Created by Fabrizio Petrellese on 20/10/24.
//

import SwiftUI

@main
struct sorVolareApp: App {
    
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            
            let string = ""
            let bindingString = Binding.constant(string)
            let resultObserver = ResultsObserver(result: bindingString)
            
            ContentView()
                .environmentObject(resultObserver)
        }
        .environmentObject(appState)
    }
}
