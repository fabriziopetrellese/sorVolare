//
//  YesBookedFlightView.swift
//  sorVolare
//
//  Created by Tulli-OS on 29/10/24.
//

import SwiftUI
import MapKit

struct SiPrenotazioneView: View {
    @State private var flyFromSelection: Location? = nil
    @State private var flyToSelection: Location? = nil
    @State private var flySelectionDefault: Location = Location(capitale: "Europe - Rome", latitude: 41.9028, longitude: 12.4964)
    @State private var route: MKRoute?
    @State private var distance: Double = 0.0
    @State private var position = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.9028, longitude: 12.4964), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)))
    @State private var isFlyFromModalPresented: Bool = false
    @State private var isFlyToModalPresented: Bool = false
    @State private var isDateModalPresented: Bool = false
    //@State private var selectedDate: Date = Date()
    @State private var selectedLocation: Location? = nil
    
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        
        let string = ""
        let bindingString = Binding.constant(string)
        let resultObserver = ResultsObserver(result: bindingString)
        
        let flyingRoute: [CLLocationCoordinate2D]? = {
            if let flyFrom = flyFromSelection, let flyTo = flyToSelection {
                return [
                    CLLocationCoordinate2D(latitude: flyFrom.latitude, longitude: flyFrom.longitude),
                    CLLocationCoordinate2D(latitude: flyTo.latitude, longitude: flyTo.longitude)
                ]
            }
            return nil
        }()
        
        ZStack {
            Image("sfondo")
                .resizable()
                .frame(width: 1*UIScreen.main.bounds.width, height: 1*UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                //Spacer()
                // Testo
                Text("Select a departure and destination")
                    .font(.system(size: 23, weight: .light, design: .rounded))
                    .padding(.top, 8)
                
                // Versione con il modale
                //HStack {
                    /*
                     Text("Fly from")
                     .font(.title3)
                     .padding(.leading)
                     */
                    Button(action: {
                        isFlyFromModalPresented.toggle()
                    }) {
                        Text(flyFromSelection?.capitale ?? "Select a departure")
                        //.font(.headline)
                            .font(.system(size: 24, weight: .light, design: .rounded))
                            .frame(maxWidth: .infinity)
                            .padding(15)
                            .background(Color.blue.opacity(0.2))
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    .sheet(isPresented: $isFlyFromModalPresented) {
                        DepartDestModal(selectedLocation: $flyFromSelection, locations: locations)
                    }
                    //.padding(.top, 3)
                //}
                
                //HStack {
                    /*
                     Text("Fly to     ")
                     .font(.title3)
                     .padding(.leading)
                     */
                    // Pulsante per aprire il modale "Fly To"
                    
                    Button(action: {
                        isFlyToModalPresented.toggle()
                    }) {
                        Text(flyToSelection?.capitale ?? "Select a destination")
                            .font(.system(size: 24, weight: .light, design: .rounded))
                        //.font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding(15)
                            .background(Color.blue.opacity(0.2))
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    .sheet(isPresented: $isFlyToModalPresented) {
                        DepartDestModal(selectedLocation: $flyToSelection, locations: locations)
                    }
                    //.padding(.top)
                //}
                //.padding(.bottom, 10)
                
                
                // Mappa
                Map(position: $position) {
                    if let route = flyingRoute {
                        MapPolyline(coordinates: route)
                            .stroke(.yellow, style: StrokeStyle(lineWidth: 1, dash: [5, 3]))
                            .foregroundStyle(Color.yellow)
                    }
                    
                    // Cerchio per il luogo di partenza
                    if let flyFrom = flyFromSelection {
                        MapCircle(center: CLLocationCoordinate2D(latitude: flyFrom.latitude, longitude: flyFrom.longitude), radius: 13000)
                            .stroke(Color.yellow.opacity(0.9), lineWidth: 8)
                    }
                    
                    // Cerchio per il luogo di destinazione
                    if let flyTo = flyToSelection {
                        MapCircle(center: CLLocationCoordinate2D(latitude: flyTo.latitude, longitude: flyTo.longitude), radius: 13000)
                            .stroke(Color.yellow.opacity(0.9), lineWidth: 8)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 360)
                .mapStyle(.hybrid(elevation: .realistic))
                .cornerRadius(1000)
                .padding(.horizontal, 10)
                .padding(.top, 5)
                
                
                
                // Visualizza la distanza
                Text(distance > 0 ? "Distance: \(String(format: "%.0f", distance)) km" : "Select a trip to see distance")
                    .font(.system(size: 23, weight: .light, design: .rounded))
                    .padding(.bottom, 5)
                
                // Pulsante per aprire il modale della data
                Button(action: {
                    isDateModalPresented.toggle()
                }) {
                    Text("Select Date: \(formattedDate(appState.flightDate))")
                        .font(.system(size: 25, weight: .light, design: .rounded))
                    //.font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.2))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .sheet(isPresented: $isDateModalPresented) {
                    //DateModalView(selectedDate: $appState.flightDate)
                    DateModal(selectedDate: $appState.flightDate)
                        .environmentObject(appState)
                }
                //.padding(.top, 15)
                
                
                // Navigazione alla prossima schermata
                NavigationStack {
                    //Text("Testo di benvenuto e spiegazioni delle fiunzionalità")
                    //NavigationLink(destination: AnxietyAnalysisView()) {
                    NavigationLink(destination: AnxietyAnalysisView(audioFileURL: getDocumentsDirectory().appendingPathComponent("recording.m4a"), observer: resultObserver)) {
                    //NavigationLink(destination: AnxietyAnalysisView(audioFileURL: getDocumentsDirectory(), observer: resultObserver)) {
                        Text("Anxiety Monitoring")
                            .font(.system(size: 25, weight: .light, design: .rounded))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                }
                
                //Spacer()
            }
            .onAppear {
                position = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: flySelectionDefault.latitude, longitude: flySelectionDefault.longitude), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)))
                
            }
            .onChange(of: flyFromSelection) { _, newValue in
                if let newLocation = newValue {
                    position = MapCameraPosition.region(
                        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: newLocation.latitude, longitude: newLocation.longitude), span: MKCoordinateSpan(latitudeDelta: 8, longitudeDelta: 8))
                    )
                    updateDistance()
                }
            }
            .onChange(of: flyToSelection) { _, newValue in
                if let _ = newValue {
                    updateDistance()
                }
            }
            .padding(.top, 10)
            //.background(.green.opacity(0.3))
            
        }
    }
    
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    
    private func updateDistance() {
        guard let ffs = flyFromSelection, let fts = flyToSelection else {
            distance = 0.0
            return
        }
        
        let fromLocation = CLLocation(latitude: ffs.latitude, longitude: ffs.longitude)
        let toLocation = CLLocation(latitude: fts.latitude, longitude: fts.longitude)
        
        distance = fromLocation.distance(from: toLocation) / 1000 // distanza in km
        
        // Imposta i delta in base alla distanza
        var delta: CLLocationDegrees
        switch distance {
        case 0..<1000: delta = 3
        case 1000..<2000: delta = 18
        case 2000..<3500: delta = 28
        case 3500..<5000: delta = 45
        case 5000..<10000: delta = 55
        default: delta = 70
        }
        
        position = MapCameraPosition.region(
            MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: (fts.latitude + ffs.latitude) / 2, longitude: (fts.longitude + ffs.longitude) / 2), span: MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta))
        )
    }
}


/*
// Modale per la selezione delle destinazioni
struct ModalView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedLocation: Location?
    var locations: [Location]
    
    
    var body: some View {
        NavigationView {
            List(locations, id: \.id) { location in
                Button(action: {
                    selectedLocation = location
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text(location.capitale)
                        .font(.system(size: 18, weight: .light))
                        .foregroundColor(.blue)
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(8) // Raggio per arrotondare gli angoli
                }
            }
            .navigationTitle(Text("Select city"))
            .navigationBarItems(trailing: Button("Close") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}


// Modale per la selezione della data
struct DateModalView: View {
    
    @Environment(\.presentationMode) var presentationMode
    //@Binding var selectedDate: Date
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
            VStack {
                //DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                DatePicker("Select Date", selection: $appState.flightDate, displayedComponents: .date)
                //.datePickerStyle(WheelDatePickerStyle())
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                
                Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
            }
            .navigationTitle("Select Date")
            .navigationBarItems(trailing: Button("Close") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
*/

#Preview {
    //FlightDetailsView()
}
