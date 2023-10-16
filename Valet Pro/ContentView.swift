//
//  ContentView.swift
//  Valet Pro
//
//  Created by Gilbert Galvan on 9/12/23.
//

import SwiftUI

struct ContentView: View {
    @State private var ticketNumber = 264084
    //@State private var showTicket = false
    @State private var ticketList: [Vehicle] = []
        
    var body: some View {
        VStack{
            VStack{
                HStack{
                    Spacer()
                    Text("Search")
                    Spacer()
                    Image(systemName:"magnifyingglass")
                    Spacer()
                    VStack{
                        Image(systemName: "plus.app.fill")
                        Button("New Ticket"){
                            ticketNumber += 1
                            let newVehicle = Vehicle(
                                color: "Red",
                                make: "Toyota",
                                model: "Camry",
                                parkingSpot: "A23",
                                ticketNumber: ticketNumber,
                                creationDate: Date())
                            ticketList.insert(newVehicle, at: 0)
                        }
                    }
                    Spacer()
                }
            ScrollView{
                    Spacer()
                    LazyVStack{
                        ForEach(ticketList, id: \.ticketNumber) { Vehicle in
                            Vehicle
                                .border(Color.black,width:2)
                                .padding(5)
                        }
                    }
                }
                HStack{
                    Button("Current"){}
                    Button("Texts"){}
                    Button("Recent"){}
                    Button("Settings"){}
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
                self.ticketNumber = ticketNumber
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
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
}
