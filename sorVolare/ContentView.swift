import SwiftUI
import UIKit


struct ContentView: View {
    @State var photos = [Photo(title: "Turbolence",file: "turbolence",description: "Turbulence represents a phenomenon that airplanes are prepared to handle; just consider that an airplane’s wings can flex. In the majority of cases, turbulence is normal. We shouldn’t fear turbulence because airplanes are designed to resist even more aggressive turbulence than what typically occurs in reality.The Federal Aviation Administration (FAA) indicates that accidents caused by turbulence represent less than 2% of all commercial air transport accidents.Richard Tobiano, chief pilot at Qantas, explained: “It’s a daily part of our job and there is nothing to fear. Airplanes are designed to handle levels of turbulence far beyond anything you might realistically face. Pilots conduct tests and simulations to handle any situation that could arise."),Photo(title: "Malfunction",file: "malfunzionamento",description: "If anyone is wondering how many planes crash each day, we would like to share a calculation made by David Ropeik from Harvard University, which indicates that the odds of an air accident are one in 11 million.   This calculation is not the only one that allows for a more relaxed perspective on the topic. Arnold Barnett, a statistics professor at MIT in Boston, stated that the risk of death for passengers on commercial airlines is one in 45 million flights.  Furthermore, airplanes are considered the safest type of transportation. To reassure those who still feel anxious about flying, there are practical factors that enhance flight safety. Airplanes undergo thorough maintenance and inspections to prevent issues. Flight crews are trained by airlines to follow operational procedures and handle any unexpected situations with passengers.  Pilot training goes beyond aircraft knowledge and flight procedures; pilots learn to be leaders capable of managing stress and unexpected challenges, both in and out of the cockpit. Additionally, the captain is never alone in operating the aircraft; the co-pilot is always present and knows how to step in if necessary."),Photo(title: "Attack",file: "pol",description: "According to data from the International Air Transport Association (IATA) and government reports, the probability of a terrorist attack on a flight is extremely low, with statistics indicating a chance of less than 1 in 20 million.  Most accidents occur on the ground, such as at airports, rather than in the air. Moreover, security measures at airports are extremely advanced and are specifically designed to minimise every risk. Every single passenger and piece of luggage goes through strict checks, and the crew members are highly trained to handle any eventuality. "),Photo(title: "Death",file: "morte",description: "If we focus solely on statistics, according to recent data, a person would have to fly every day for 103,239 years before losing their life in an air accident (though they would pass away sooner due to obvious age and biological reasons). Flying has become so safe that 2023 marked the best period since commercial aviation exists. In Italy, seven out of eight major areas ended 2023 with a fatal accident rate of zero.  “The 2023 safety data continue to show that flying is the safest mode of transport,” stated Willie Walsh, Director General of IATA. “Aviation prioritise safety as its primary concern, as demonstrated by last year’s performance, which also saw the lowest risk of mortality and the lowest rate of ‘all accidents’ ever recorded.”  Road accidents are the leading cause of death for young people aged 15-29. Oxford University calculated that in 2006, British people had a 1 in 36,512 chance of dying in a car accident and a 1 in 3.5 million chance of dying in a plane crash. ")]
    
    @AppStorage("shouldShowOnboarding") var shouldShowOnboarding = true
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Image("sfondo")
                    .resizable()
                    .frame(width: 1*UIScreen.main.bounds.width, height: 1*UIScreen.main.bounds.height)
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing:30) {
                    Spacer()
                    Text("Welcome to your relaxation area!")
                        .foregroundColor(.black)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.top, 10)
                    /*Image(systemName: "airplane")
                     .resizable()
                     .frame(width: 100, height: 100)*/
                    
                    Text("🛩️")
                        .font(.system(size: 100))
                    
                    
                    
                    
                    // Sovrapposizione del testo e dei link
                    VStack(spacing: 15) {
                        
                        // Testo sopra l'immagine, con dimensioni ridotte per adattarsi meglio
                        Text("Have you already booked a flight?")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                            .padding(.horizontal, 10)
                        
                        // Link "No" e "Sì" posizionati sotto il testo
                        HStack(spacing: 30) {
                            NavigationLink(destination: SiPrenotazioneView()) {
                                Text("Yes")
                                    .font(.subheadline)
                                    .padding(.horizontal, 15)
                                    .padding(.vertical, 8)
                                    .background(Color.cyan.opacity(0.2))
                                    .cornerRadius(10)
                                    .foregroundColor(.black)
                            }
                            
                            NavigationLink(destination: NoPrenotazioneView(photos: $photos)) {
                                Text("No")
                                    .font(.subheadline)
                                    .padding(.horizontal, 15)
                                    .padding(.vertical, 8)
                                    .background(Color.cyan.opacity(0.2))
                                    .cornerRadius(10)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    .padding()
                    Spacer()
                }
                
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                // Colore blu rilassante di sfondo
            }
        }
        .background(Image("sfondo").resizable())
        .fullScreenCover(isPresented: $shouldShowOnboarding, content: {
            OnboardingView(shouldShowOnboarding: $shouldShowOnboarding)
        })
    }
}

struct Photo:Identifiable, Codable {
    var id = UUID() //chiave unica,la sceglie il protocollo,chiave per ohni istanza della struct
    var title:String
    var file:String
    var multiplyRed=1.0
    var multiplyGreen=1.0
    var multiplyBlue=1.0
    var saturation:Double?
    var contrast:Double?
    var original = true
    var description:String
    
}
