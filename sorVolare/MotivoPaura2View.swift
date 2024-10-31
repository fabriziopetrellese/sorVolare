//
//  MotivoPaura2View.swift
//  sorVolare
//
//  Created by Tulli-OS on 29/10/24.
//

import SwiftUI

struct MotivoPaura2View: View {
    @Binding var showModal1: Bool

    var body: some View {
        ScrollView{
            VStack{
                Image("malfunzionamento")
                HStack{
                    Text("Se qualcuno tra voi si sta ponendo la domanda quanti aerei cadono al giorno, per cercare di evitare di perdersi in mille pensieri e congetture sottoponiamo proprio alla vostra attenzione il risultato di un calcolo effettuato da David Ropeik della Harvard University. Esso può apparire oltremodo sorprendente agli occhi di chi teme di volare. Ropeik infatti ha calcolato che le probabilità di  un incidente aereo sono una su 11 milioni. Per fare un veloce e significativo confronto, sono maggiori le probabilità di morire a causa dell’attacco di uno squalo, in quanto in questo caso le probabilità corrispondono a una su 3 milioni.Il calcolo di Ropeik non è l’unico a poter consentire una riflessione più serena sull’argomento paura di volare. Arnold Barnett, professore di statistica del MIT di Boston, ha dichiarato che il rischio di morte per i passeggeri di linee aeree commerciali corrisponde a una su 45 milioni di voli.Un altro degli interrogativi che può certo fare capolino nella mente di chi teme e si domanda quale sia la probabilità di incidenti aerei è quello relativo a quanto sia in generale sicuro viaggiare in aereo. l’aereo viene considerato addirittura il mezzo di trasporto più sicuro.A poter funzionare da rassicurazione per tutti coloro che  avvertono ancora tensione all’idea di partire per la prossima destinazione di vacanza, ci sono tutti quei fattori collegati in modo assolutamente pratico al grande tema della sicurezza in volo. Innanzitutto, gli aerei sono sottoposti a manutenzione e controlli scrupolosi volti a prevenire qualsiasi problema.Il personale di volo viene formato dalle compagnie aeree per seguire le diverse procedure operative richieste durante il volo e per far fronte alle situazioni poco piacevoli che potrebbero crearsi con i passeggeri.Stesso discorso vale per i piloti. La formazione di un pilota non si limita alla conoscenza dell’aeromobile e delle procedure di volo. Il pilota viene formato per essere un leader capace di gestire situazioni di stress e imprevisti, fuori e dentro la cabina.Il primo pilota, inoltre, non è mai l’unica persona presente sull’aereo in grado di guidare tale mezzo di trasporto. Con lui c’è anche il copilota, che certo sa come intervenire in caso di bisogno.")
                    
                }.padding()
                
            }
            
        }
    }
}

#Preview {
    //MotivoPaura2View()
}
