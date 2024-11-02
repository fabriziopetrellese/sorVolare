import SwiftUI

struct MotivoPaura3View: View {
    @Binding var showModal2: Bool
    var body: some View {
    
            ZStack{
                Color(red: 166/255, green: 32/255, blue: 20/255)
                    .edgesIgnoringSafeArea(.all)
                ScrollView{
                VStack{
                    Image("pasted")
                    Spacer()
                    HStack{
                        Text("Secondo alcuni dati dell'Associazione Internazionale del Trasporto Aereo (IATA) e dei rapporti governativi, la probabilità di un attacco terroristico su un volo è estremamente bassa, con statistiche che indicano una probabilità inferiore a 1 su 20 milioni.La maggior parte degli incidenti avviene a terra, come negli aeroporti, piuttosto che in volo.Inoltre le misure di sicurezza negli aeroporti sono estremamente avanzate e sono state progettate proprio per ridurre al minimo ogni rischio. Ogni singolo passeggero e bagaglio passa attraverso controlli severi, e gli equipaggi sono altamente addestrati per gestire qualsiasi evenienza.")
                            .foregroundStyle(.white)
                            .bold()
                            .italic()
                            .shadow(color: Color .gray,radius:2, x:1,y:1)
                        
                        
                    }.padding()
                    
                }
                
            }
        }
    }
}

#Preview {
    //MotivoPaura3View()
}
