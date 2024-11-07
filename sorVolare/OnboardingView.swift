//
//  OnboardingView.swift
//  sorVolare
//
//  Created by Fabrizio Petrellese on 07/11/24.
//

import SwiftUI
import UserNotifications

struct OnboardingView: View {
    @Binding var shouldShowOnboarding: Bool
    
    var body: some View {
        TabView {
            
            FirstPageView(shouldShowOnboarding: $shouldShowOnboarding)
            
            SecondPageView(shouldShowOnboarding: $shouldShowOnboarding)
            
            ThirdPageView(shouldShowOnboarding: $shouldShowOnboarding)
            
            
        }
        .tabViewStyle(.page)
    }
}


struct FirstPageView: View {
    @Binding var shouldShowOnboarding: Bool
    
    var body: some View {
        Text("Prima pagina")
    }
}

struct SecondPageView: View {
    @Binding var shouldShowOnboarding: Bool
    
    var body: some View {
        VStack {
            Text("Seconda pagina")
        }
    }
}



struct ThirdPageView: View {
    @Binding var shouldShowOnboarding: Bool
    let center = UNUserNotificationCenter.current()
    
    var body: some View {
        VStack {
            
            Button(action: {
                shouldShowOnboarding = false
                center.requestAuthorization(options: [.alert, .sound, .badge]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }) {
                Text("Inizia a usare l'app")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            
        }
    }
}
