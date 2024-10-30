//
//  YesBookedFlightView.swift
//  sorVolare
//
//  Created by Tulli-OS on 29/10/24.
//

import SwiftUI
import MapKit
import Foundation

struct SiPrenotazioneView: View {
    @State private var departure: Location? = nil
    @State private var destination: Location? = nil
    let startingPoint: Location = Location(capitale: "Europe - Rome", latitude: 41.9028, longitude: 12.4964)
    
    //@State private var route: MKRoute?
    @State private var distance: Double = 0.0
    @State private var position = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.9028, longitude: 12.4964), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)))
    
    @State private var flyFromModal: Bool = false
    @State private var flyTo: Bool = false
    @State private var selectedLocation: Location? = nil
    
    @State private var dateModal: Bool = false
    @State private var selectedDate = Date()
    
    @State private var hours: Double = 0.0
    let planeAvgSpeed: Double = 750.0
    
    var body: some View {
        let flyingRoute: [CLLocationCoordinate2D]? = {
            if let flyFrom = departure, let flyTo = destination {
                return [
                    CLLocationCoordinate2D(latitude: flyFrom.latitude, longitude: flyFrom.longitude),
                    CLLocationCoordinate2D(latitude: flyTo.latitude, longitude: flyTo.longitude)
                ]
            }
            return nil // Restituisce nil se uno dei valori è NULL
        }()
        
            VStack {
                /*
                 Text("Select a departure and destination")
                 .font(.system(size: 25, weight: .light, design: .rounded))
                 .padding(.vertical, 3)
                 */
                
                // "Fly from" modal
                Button(action: {
                    flyFromModal.toggle()
                }) {
                    Text(departure?.capitale ?? "Select a departure")
                        .font(.system(size: 25, weight: .light, design: .rounded))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .sheet(isPresented: $flyFromModal) {
                    DepartDestModal(selectedLocation: $departure, locations: locations)
                }
                .padding(.top, 5)
                
                // "Fly to" modal
                Button(action: {
                    flyTo.toggle()
                }) {
                    Text(destination?.capitale ?? "Select a destination")
                        .font(.system(size: 25, weight: .light, design: .rounded))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                }
                .sheet(isPresented: $flyTo) {
                    DepartDestModal(selectedLocation: $destination, locations: locations)
                }
                
                
                // Mappa
                Map(position: $position) {
                    if let route = flyingRoute {
                        MapPolyline(coordinates: route)
                            .stroke(.yellow, style: StrokeStyle(lineWidth: 1, dash: [5, 3]))
                            .foregroundStyle(Color.yellow)
                    }
                    
                    // Cerchio per il luogo di partenza
                    if let flyFrom = departure {
                        MapCircle(center: CLLocationCoordinate2D(latitude: flyFrom.latitude, longitude: flyFrom.longitude), radius: 13000)
                            .stroke(Color.yellow.opacity(0.9), lineWidth: 8)
                    }
                    
                    // Cerchio per il luogo di destinazione
                    if let flyTo = destination {
                        MapCircle(center: CLLocationCoordinate2D(latitude: flyTo.latitude, longitude: flyTo.longitude), radius: 13000)
                            .stroke(Color.yellow.opacity(0.9), lineWidth: 8)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 380)
                .mapStyle(.hybrid(elevation: .realistic))
                .cornerRadius(1000)
                .padding(.horizontal, 10)
                .padding(.vertical, 8)
                
                
                // Visualizza la distanza del viaggio
                Text(distance > 0 ? "Distance: \(String(format: "%.0f", distance)) km - Flight hours: \(String(format: "%.1f", hours))" : "Select a trip to see the distance")
                    .font(.system(size: 22, weight: .light, design: .rounded))
                    .padding(.bottom, 8)
                    .foregroundStyle(.black.opacity(0.8))
                
                // Pulsante per aprire la modal della data
                Button(action: {
                    dateModal.toggle()
                }) {
                    Text("Select Date: \(selectedDate.formatted(date: .abbreviated, time: .omitted))")
                        .font(.system(size: 25, weight: .light, design: .rounded))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .sheet(isPresented: $dateModal) {
                    DateModal(selectedDate: $selectedDate)
                }
                //.padding(.top, 15)
                
                //Spacer()
                
            } //VStack
            
            //.background(.green.opacity(0.3))
            //.background(.cyan.opacity(0.15))
            .onAppear {
                /* Togli il commento se non usi il modale
                 if let first = locations.first {
                 flyFromSelection = first
                 flyToSelection = first
                 }*/
                
                position = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: startingPoint.latitude, longitude: startingPoint.longitude), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)))
            }
            .onChange(of: departure) { _, newValue in
                if let newLocation = newValue {
                    position = MapCameraPosition.region(
                        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: newLocation.latitude, longitude: newLocation.longitude), span: MKCoordinateSpan(latitudeDelta: 8, longitudeDelta: 8))
                    )
                    updateDistance()
                }
                
                //calcolo le ore di volo
                hours = distance/planeAvgSpeed
            }
            .onChange(of: destination) { _, newValue in
                if let _ = newValue {
                    updateDistance()
                }
                
                //calcolo le ore di volo
                hours = distance/planeAvgSpeed
            }
        
        
    }//body
    
    /*func deleteItem(offsets: IndexSet) {
     photos.remove(atOffsets: offsets)
     save()
     }
     */
    
    
    
    func updateDistance() {
        guard let ffs = departure, let fts = destination else {
            distance = 0.0
            return
        }
        
        let fromLocation = CLLocation(latitude: ffs.latitude, longitude: ffs.longitude)
        let toLocation = CLLocation(latitude: fts.latitude, longitude: fts.longitude)
        
        distance = fromLocation.distance(from: toLocation) / 1000 // distanza in km
        
        // Imposta i delta in base alla distanza
        var delta: CLLocationDegrees
        switch distance {
        case 0..<500:
            delta = 5
        case 500..<1000:
            delta = 10
        case 1000..<2000:
            delta = 19
        case 2000..<3500:
            delta = 30
        case 3500..<5000:
            delta = 45
        case 5000..<7500:
            delta = 65
        case 7500..<10000:
            delta = 73
        default: delta = 80
        }
        
        position = MapCameraPosition.region(
            MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: (fts.latitude + ffs.latitude) / 2, longitude: (fts.longitude + ffs.longitude) / 2), span: MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta))
        )
    }
    }

#Preview {
    SiPrenotazioneView()
}



