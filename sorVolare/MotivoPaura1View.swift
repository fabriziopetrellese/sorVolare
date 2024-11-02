import SwiftUI

struct MotivoPaura1View: View {
    @Binding var showModal: Bool
    
    var body: some View {
        ZStack{
            Color(red: 166/255, green: 32/255, blue: 20/255)
                .edgesIgnoringSafeArea(.all)
            ScrollView{
                VStack{
                    Image("pasted")
                    HStack{
                        Text("                                                                                      Le turbolenze costituiscono un fenomeno che l’aereo è pronto a sostenere, basta pensare che le ali dell’aereo possono flettersi. Rappresentano, nella stragrande maggioranza dei casi, la normalità.  Non dobbiamo avere paura delle turbolenze, perché gli aerei sono progettati per resistere anche alle turbolenze più aggressive di quelle che accadono nella realtà.  La Federal Aviation Administration (FAA) indica che gli incidenti causati da turbolenza rappresentano meno del 2% degli incidenti complessivi nel trasporto aereo commerciale.Richard Tobiano, pilota capo della Qantas aveva spiegato – è una parte quotidiana del nostro lavoro e non c’è nulla da temere. Gli aerei sono progettati per affrontare livelli di turbolenza ben oltre qualsiasi cosa potresti realisticamente incontrare.I piloti effettuano test e simulazioni per controllare qualsiasi situazione che possa verificarsi.")
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
    //MotivoPaura1View()
}
