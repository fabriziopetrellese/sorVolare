//
//  Notifiche.swift
//  sorVolare
//
//  Created by Fabrizio Petrellese on 01/11/24.
//

import UserNotifications
import SwiftUI

struct Notifiche: View {
    let center = UNUserNotificationCenter.current()
    
    var body: some View {
        VStack {
            
            //una volta premuto questo bottone, bisogna acconsentire alle notifiche
            Button("Richiedi permesso") {
                center.requestAuthorization(options: [.alert, .sound, .badge]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }//Primo bottone
            
            
            //clicca questo bottone, blocca lo schermo dell'iphone e aspetta 5 secondi per la notifica
            Button("Invia notifica") {
                let content = UNMutableNotificationContent()
                content.title = "OverFly"
                content.body = "It's time for square breathing, take a moment for yourself!🌅"
                content.sound = UNNotificationSound.default
                
                // show this notification five seconds from now
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

                // choose a random identifier
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                // add our notification request
                UNUserNotificationCenter.current().add(request)
            }.padding()//Secondo button
            
            
        }//vstack
        
    }
}

#Preview {
    Notifiche()
}
