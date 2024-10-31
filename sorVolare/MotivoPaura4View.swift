//
//  MotivoPaura4View.swift
//  sorVolare
//
//  Created by Tulli-OS on 29/10/24.
//

import SwiftUI

struct MotivoPaura4View: View {
    @Binding var showModal3: Bool
    var body: some View {
        ScrollView{
            VStack{
                Image("morte")
                Spacer()
                HStack{
                    Text("Se si guardasse soltanto alla statistica, con i numeri attuali una persona dovrebbe volare tutti i giorni, per 103.239 anni, prima di perdere la vita in un incidente aereo (ma muore prima per evidenti ragioni anagrafiche e biologiche). Tanto è diventato sicuro volare che il 2023 è stato il periodo migliore da quando esiste l’aviazione commerciale.A livello territoriale, sette macro-aree su otto hanno chiuso il 2023 con un tasso d’incidenti mortali pari a zero.«I dati sulla sicurezza del 2023 continuano a dimostrare che il volo è la modalità di trasporto più sicura», commenta in una nota Willie Walsh, direttore generale della Iata. «L’aviazione attribuisce la massima priorità alla sicurezza e questo è dimostrato dalle prestazioni dell’anno passato che ha visto anche il più basso rischio di mortalità e il tasso di “tutti gli incidenti” mai registrato».La strada è la principale causa di morte per i giovani tra i 15-29 anni di età. L'Università di Oxford ha calcolato che nel 2006, gli inglesi avevano una probabilità su 36.512 di morire in un incidente automobilistico e una su 3,5 milioni di morire in un incidente aereo.")
                    
                    
                }.padding()
                
            }
            
        }
    }
}

#Preview {
    //MotivoPaura4View()
}
