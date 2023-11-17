//
//  ContentView.swift
//  Valet Pro
//
//  Created by Gilbert Galvan on 9/12/23.
//

import SwiftUI

class Vehicle: ObservableObject {
    var ticketNumber: Int
    @Published var color: String
    @Published var make: String
    @Published var model: String
    @Published var parkingSpot: String
    var creationDate: Date

    init(color: String, make: String, model: String, parkingSpot: String, ticketNumber: Int, creationDate: Date) {
        self.color = color
        self.make = make
        self.model = model
        self.parkingSpot = parkingSpot
        self.ticketNumber = ticketNumber + 1
        self.creationDate = creationDate
    }
}

struct ContentView: View {
    @State private var ticketNumber = 264084
    @State private var ticketList: [Vehicle] = []
    @State private var isAddingTicket = false
    @State private var scrollOffset: CGFloat = 0
    @State private var searchQuery = ""
    @State private var isShowingSettings = false
    @State private var isEdittingTicket = false
    @State private var vehicleToEdit: Vehicle?

    var filteredTickets: [Vehicle] {
            if searchQuery.isEmpty {
                return ticketList
            } else {
                return ticketList.filter { "\($0.ticketNumber)".contains(searchQuery)}
            }
        }
    
    var body: some View {
            VStack {
                VStack {
                    HStack {
                        Spacer()
                        Spacer()
                        TextField("Search", text: $searchQuery)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Spacer()
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
                            ForEach(filteredTickets, id: \.ticketNumber) { vehicle in
                                VehicleRow(vehicle: vehicle, isEdittingTicket: $isEdittingTicket, vehicleToEdit: $vehicleToEdit)
                                    .border(Color.black, width: 2)
                                    .padding(5)
                                    .onTapGesture{
                                        vehicleToEdit = vehicle
                                        isEdittingTicket = true
                                    }
                            }
                        }
                    }
                    HStack {
                        Spacer()
                        VStack{
                            Image(systemName: "car.side.fill")
                            Button("Current") {}
                        }
                        Spacer()
                        VStack{
                            Image(systemName: "message.fill")
                            Button("Texts") {}
                        }
                        Spacer()
                        VStack{
                            Image(systemName: "star.fill")
                            Button("Recent") {}
                        }
                        Spacer()
                        VStack{
                            Image(systemName: "gear")
                            Button("Settings") {
                                isShowingSettings = true
                            }
                            .sheet(isPresented: $isShowingSettings){
                                SettingsView()
                            }
                        }
                        Spacer()
                    }
                }
            }
        }
    
    struct VehicleRow: View {
        @ObservedObject var vehicle: Vehicle
        @Binding var isEdittingTicket: Bool
        @Binding var vehicleToEdit: Vehicle?
        @State private var isConfirmationSheetPresented = false
        @State private var isPullViewPresented = false
        //@State private var selectedVehicleForPull = Vehicle?
        
        var body: some View {
            HStack {
                Spacer()
                VStack {
                    Text("\(vehicle.ticketNumber)")
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
                    //selectedVehicleForPull = vehicle
                    isConfirmationSheetPresented = true
                }
                .sheet(isPresented: $isConfirmationSheetPresented){
                    
                    VStack{
                        Text("Confirm Pull for ticket: \(vehicle.ticketNumber)")
                            .font((.headline))
                            .padding()
                        Button("Confirm"){
                            isPullViewPresented = true
                            isConfirmationSheetPresented = false
                        }
                        .padding()
                        Button("Cancel"){
                            isConfirmationSheetPresented = false
                        }
                        .padding()
                    }
                }
                    .sheet(isPresented: $isPullViewPresented){
                        PullView(vehicle: vehicle)
                }
                Button("Edit") {
                        vehicleToEdit = vehicle
                        isEdittingTicket = true
                }
                .sheet(isPresented: $isEdittingTicket) {
                    if let vehicle = vehicleToEdit {
                        EdittingTicketView(vehicle: vehicle)
                        //isEdittingTicket = false
                    }
                }
                .foregroundColor(.green)
                Spacer()
            }
        }
        private var formattedDate: String {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/yy HH:mm"
            return dateFormatter.string(from: vehicle.creationDate)
            }
    }
    
    struct TicketCreationView: View {
        @Binding var ticketNumber: Int
        @State private var color: String = ""
        @State private var make: String = ""
        @State private var model: String = ""
        @State private var parkingSpot: String = ""
        let manufacturers = ["Toyota", "Honda", "Ford", "Chevrolet", "BMW", "Mercedes-Benz", "Audi", "Nissan", "Volkswagen"]
        @State private var selectedManufacturer = "Toyota"
        let colors = ["Black", "White", "Gray", "Blue", "Red", "Silver", "Orange", "Yellow", "Custom"]
        @State private var selectedColor = "Black"



        let onCreation: (Vehicle) -> Void

        var body: some View {
            Form {
                Section {
                    Picker("Select a Color", selection: $selectedColor) {
                        ForEach(colors, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
                Section {
                    Picker("Select a Manufacturer", selection: $selectedManufacturer) {
                        ForEach(manufacturers, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
                TextField("Model", text: $model)
                TextField("Parking Spot", text: $parkingSpot)
                
                
                Button("Save") {
                    let newVehicle = Vehicle(
                        color: selectedColor,
                        make: selectedManufacturer,
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
    
    public struct EdittingTicketView: View{
        @ObservedObject var vehicle: Vehicle
        let colors = ["Black", "White", "Gray", "Blue", "Red", "Silver", "Orange", "Yellow", "Custom"]
        let manufacturers = ["Toyota", "Honda", "Ford", "Chevrolet", "BMW", "Mercedes-Benz", "Audi", "Nissan", "Volkswagen"]
        
        var body: some View {
            Form {
                Section {
                    Picker("Select a Color", selection: $vehicle.color) {
                        
                        ForEach(colors, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
                
                Section {
                    Picker("Select a Manufacturer", selection: $vehicle.make) {
                        ForEach(manufacturers, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
                
                TextField("Model", text: $vehicle.model)
                TextField("Parking Spot", text: $vehicle.parkingSpot)
                
            }
                    .navigationTitle("Edit Ticket")
            
        }
    }
    
    struct PullView: View {
        
        @State private var selectedValidation = 0
        private let validationOptions = ["Restaurant 1","Restaurant 2", "Restaurant 3"]
        var vehicle: Vehicle
        
        var body: some View{
            VStack{
                Picker("Select Validation",selection:$selectedValidation){
                    ForEach(0..<validationOptions.count){index in Text(validationOptions[index])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                Text("Ticket Number: \(vehicle.ticketNumber)")//Show the ticket number here)
                    .font(.system(size:25))
                Text("Total Time: \(formattedTimeSpent)")//Show the ticket number here)
                    .font(.system(size:25))
                Text("Total Cost: \(formattedTotalCharge)")//Show the ticket number here)
                    .font(.system(size:25))
                
            }
        }
        
        private var formattedTimeSpent: String{
            
            let timeInterval = Date().timeIntervalSince(vehicle.creationDate)
            let hours = Int(timeInterval/3600)
            let minutes = Int((timeInterval.truncatingRemainder(dividingBy: 3600))/60)
            
            return "\(hours) hours \(minutes) minutes"
        }
        
        private var formattedTotalCharge: String{
            let totalCharge = calculateTotalCharge(validationOption: selectedValidation)
            return String(format: "$%.2f",totalCharge)
        }
        
        private func calculateTotalCharge(validationOption: Int) -> Double {
            let timeInterval = Date().timeIntervalSince(vehicle.creationDate)
            let hours = timeInterval / 3600
            let portionOfAnHour = ceil(hours) // Round up to the nearest whole hour

            switch validationOption {
            case 0: // Validation 1
                return portionOfAnHour * 5
            case 1: // Validation 2
                return portionOfAnHour * 10
            case 2: // Validation 3
                return max(portionOfAnHour - 3, 0) * 5
            default:
                return 0
            }
        }

        
    }
    
    
    
    struct SettingsView: View{
        var body: some View{
            
            
            VStack{
                HStack{
                    Spacer()
                    Text("Log off")
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .font(.system(size: 25))
                }
                    .border(Color.black, width: 2)
                    .padding(5)
                HStack{
                    Spacer()
                    Text("Reports")
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .font(.system(size: 25))
                }
                    .border(Color.black, width: 2)
                    .padding(5)
                HStack{
                    Spacer()
                    Text("Time Sheet")
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .font(.system(size: 25))
                }
                    .border(Color.black, width: 2)
                    .padding(5)

            }
            
            
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
}
