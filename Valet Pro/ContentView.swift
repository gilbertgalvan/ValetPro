//
//  ContentView.swift
//  Valet Pro
//
//  Created by Gilbert Galvan on 9/12/23.
//

import SwiftUI

struct ContentView: View {
    @State private var ticketNumber = 264084
    @State private var ticketList: [Vehicle] = []
    @State private var isAddingTicket = false

        
    var body: some View {
            VStack {
                VStack {
                    HStack {
                        Spacer()
                        Text("Search")
                        Spacer()
                        Image(systemName: "magnifyingglass")
                        Spacer()
                        VStack {
                            Image(systemName: "plus.app.fill")
                            Button("New Ticket") {
                                isAddingTicket = true
                            }
                            .sheet(isPresented: $isAddingTicket) {
                                TicketCreationView(ticketNumber: $ticketNumber) { vehicle in
                                    ticketList.insert(vehicle, at: 0)
                                    isAddingTicket = false
                                }
                            }
                        }
                        Spacer()
                    }
                    ScrollView {
                        Spacer()
                        LazyVStack {
                            ForEach(ticketList, id: \.ticketNumber) { vehicle in
                                vehicle
                                    .border(Color.black, width: 2)
                                    .padding(5)
                            }
                        }
                    }
                    HStack {
                        Button("Current") {}
                        Button("Texts") {}
                        Button("Recent") {}
                        Button("Settings") {}
                    }
                }
            }
        }
    
    struct Vehicle: View {
        var ticketNumber: Int
        var color: String
        var make: String
        var model: String
        var parkingSpot: String
        var creationDate: Date
        
        init(color: String, make: String, model: String, parkingSpot: String, ticketNumber: Int, creationDate: Date) {
                self.color = color
                self.make = make
                self.model = model
                self.parkingSpot = parkingSpot
                self.ticketNumber = ticketNumber + 1
                self.creationDate = creationDate
        }
        
        init() {
                self.init(
                    color: "Unknown",
                    make: "Unknown",
                    model: "Unknown",
                    parkingSpot: "Unknown",
                    ticketNumber: 0,
                    creationDate: Date()
                )
        }
        
        var body: some View {
            HStack {
                Spacer()
                VStack {
                    Text("\(ticketNumber)")
                        .font(.system(size: 25))
                    Text("\(formattedDate)")
                        .font(.system(size: 15))
                }
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Button("Pull") {
                    // Add your action for the "Pull" button here
                }
                Button("Edit") {
                    // Add your action for the "Edit" button here
                }
                .foregroundColor(.green)
                Spacer()
            }
        }
        private var formattedDate: String {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/yy HH:mm"
                return dateFormatter.string(from: creationDate)
            }
    }
    
    struct TicketCreationView: View {
        @Binding var ticketNumber: Int
        @State private var color: String = ""
        @State private var make: String = ""
        @State private var model: String = ""
        @State private var parkingSpot: String = ""

        let onCreation: (Vehicle) -> Void

        var body: some View {
            Form {
                TextField("Color", text: $color)
                TextField("Make", text: $make)
                TextField("Model", text: $model)
                TextField("Parking Spot", text: $parkingSpot)
                
                Button("Save") {
                    let newVehicle = Vehicle(
                        color: color,
                        make: make,
                        model: model,
                        parkingSpot: parkingSpot,
                        ticketNumber: ticketNumber,
                        creationDate: Date()
                    )
                    ticketNumber += 1
                    onCreation(newVehicle)
                }
            }
            .navigationTitle("Create Ticket")
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
}
