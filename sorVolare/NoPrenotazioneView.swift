import SwiftUI

struct NoPrenotazioneView: View {
    @Binding var photos: [Photo]
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
           
           
            VStack {
                // Titolo della lista
                Text("Main fears when facing a flight")
                    .foregroundColor(.black)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 10)
                
                // Lista delle foto
                List {
                    ForEach($photos, id: \.id) { $photo in
                        NavigationLink(destination: DetailView(photo: $photo, photos: $photos)) {
                            HStack {
                                Image(photo.file)
                                    .resizable()
                                    .cornerRadius(10)
                                    .frame(width: 90, height: 90)
                                Text(photo.title.uppercased())
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            appState.noClicked = true
            if appState.noClicked && !appState.yesClicked {
                let content = UNMutableNotificationContent()
                content.title = "OverFly"
                content.body = "It's time for square breathing, take a moment for yourself!"
                content.sound = UNNotificationSound.default
                
                // Mostra questa notifica tra 3 giorni da ora
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 259200, repeats: true)
                
                // Crea una richiesta di notifica
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                // Aggiungi la notifica
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
}
     
#Preview {
    //NoPrenotazioneView()
}
