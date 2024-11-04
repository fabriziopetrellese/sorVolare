import SwiftUI

struct NoPrenotazioneView: View {
    @Binding var photos: [Photo]
    /*
    @State private var showModal = false
    @State private var showModal1 = false
    @State private var showModal2 = false
    @State private var showModal3 = false
     */
    var body:some View {
        
        ZStack{
            Color.cyan.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
            //VStack {
            List{
                
            //}
                ForEach($photos, id: \.id){ $photo in
                    NavigationLink(destination: DetailView(photo : $photo,photos : $photos)){
                        
                        HStack{
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
    
    
    
    /*
    var header: some View {
        VStack {
            HStack{
                Image(systemName: "tornado")
                Button("Turbolence.")  {
                    showModal = true
                    
                } .shadow(color: Color .gray,radius:2, x:1,y:1)
                    .foregroundStyle(.black)
                    .background{
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(.cyan).opacity(0.4)
                    }
                
            }
        }
        .sheet(isPresented: $showModal) {
            // La vista del modale
            MotivoPaura1View(showModal: $showModal)
        }
    }
        
            
            
            /*NavigationLink(destination: MotivoPaura1View()) {
                Image("turbo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100,alignment: .leading)
                Text("Turbolenze")
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .frame(width: 100, height: 100,alignment: .leading)
                
                
                
            }*/
            
            
        
       
        
    
    var header1:some View{
        
        
        VStack {
            HStack{
                Image(systemName: "wrench.fill")
                Button("Malfunction.") {
                    showModal1 = true
                } .shadow(color: Color .gray,radius:2, x:1,y:1)
                    .foregroundStyle(.black)
                    .background{
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(.cyan).opacity(0.4)
                    }
            }
        }
        .sheet(isPresented: $showModal1) {
            // La vista del modale
            MotivoPaura2View(showModal1: $showModal1)
        }
    }
    
    var header2:some View{
        
        
        VStack {
            HStack{
                Image(systemName: "flame.fill")
                Button("Attack.") {
                    showModal2 = true
                } .shadow(color: Color .gray,radius:2, x:1,y:1)
                    .foregroundStyle(.black)
                    .background{
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(.cyan).opacity(0.4)
                    }
            }
        }
        .sheet(isPresented: $showModal2) {
            // La vista del modale
            MotivoPaura3View(showModal2: $showModal2)
        }
        
    }
    var header3:some View{
        
        
        VStack {
            HStack{
                Image(systemName: "heart.fill")
                Button("Death.") {
                    showModal3 = true
                } .shadow(color: Color .gray,radius:2, x:1,y:1)
                    .foregroundStyle(.black)
                    .background{
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(.cyan).opacity(0.4)
                    }
            }}
        .sheet(isPresented: $showModal3) {
            // La vista del modale
            MotivoPaura4View(showModal3: $showModal3)
        }
       */
    }
}
     
#Preview {
    //NoPrenotazioneView()
}
