//
//  Valet_ProTests.swift
//  Valet ProTests
//
//  Created by Gilbert Galvan on 12/5/23.
//

import XCTest
import SwiftUI
@testable import Valet_Pro

final class ContentView: View {
    @ObservedObject var viewModel: ContentViewModel
    @State var searchQuery: String = ""
    @Published var ticketList: [Vehicle] = []

    init(viewModel: ContentViewModel) {
        self.viewModel = viewModel
    }
    
    func setSearchQuery(_ query: String) {
            self.searchQuery = query
    }
    
    func addNewVehicle(_ vehicle: Vehicle) {
        // Increment the ticketNumber and then append the vehicle to the list
            vehicle.ticketNumber = viewModel.ticketList.count + 1
            viewModel.ticketList.append(vehicle)
        }
    
    var body: some View{
        VStack{
            
        }
    }
  
}

class ContentViewModel: ObservableObject {
    @Published var ticketList: [Vehicle] = []

    
}

final class Valet_ProTests: XCTestCase {
    
    //tests the inititialization of a vehicle object
    func testVehicleInitialization() {
        let arrivalDate = Date()
        let vehicle = Vehicle(color: "Red", make: "Toyota", model: "Camry", parkingSpot: "A1", ticketNumber: 1, arrivalDate: arrivalDate, amountPayed: 0.0)

        XCTAssertEqual(vehicle.color, "Red")
        XCTAssertEqual(vehicle.make, "Toyota")
        XCTAssertEqual(vehicle.model, "Camry")
        XCTAssertEqual(vehicle.parkingSpot, "A1")
        XCTAssertEqual(vehicle.ticketNumber, 2) // *Also checks if ticketNumber is incremented correctly
        XCTAssertEqual(vehicle.arrivalDate, arrivalDate)
        XCTAssertEqual(vehicle.amountPayed, 0.0)
        }
    
    //tests the functionality of the setValidationOption function for nil,1,2,and 0
    func testSetValidationOption() {
        let vehicle = Vehicle(color: "Blue", make: "Honda", model: "Accord", parkingSpot: "B2", ticketNumber: 1, arrivalDate: Date(), amountPayed: 0.0)

        XCTAssertNil(vehicle.validationOption)

        vehicle.setValidationOption(1)

        XCTAssertEqual(vehicle.validationOption, 1)
        
        vehicle.setValidationOption(2)
        
        XCTAssertEqual(vehicle.validationOption, 2)
        
        vehicle.setValidationOption(0)
        
        XCTAssertEqual(vehicle.validationOption, 0)
        
    }
    
    //tests for the successful creation of a/multiple vehicles
    // as well as successfully appending to the array
    // 'ticketList'
    func testCreateNewVehicle() {
        let viewModel = ContentViewModel()
        
        let initialTicketCount = viewModel.ticketList.count
        let newVehicle = Vehicle(
            color: "Red",
            make: "Toyota",
            model: "Camry",
            parkingSpot: "A1",
            ticketNumber: 0,
            arrivalDate: Date(),
            amountPayed: 0.0
        )
        viewModel.ticketList.append(newVehicle)
        
        XCTAssertEqual(viewModel.ticketList.count, initialTicketCount + 1)
        
        let newVehicle2 = Vehicle(
            color: "Red",
            make: "Toyota",
            model: "Corolla",
            parkingSpot: "A2",
            ticketNumber: 0,
            arrivalDate: Date(),
            amountPayed: 0.0
        )

        viewModel.ticketList.append(newVehicle2)

        XCTAssertEqual(viewModel.ticketList.count, initialTicketCount + 2)
    }
    
    //tests the functionality of the ticketNumber being incremented by 1 each time a new ticket is issued
    func testAddNewVehicleUpdatesTicketNumber() {
        let viewModel = ContentViewModel()
        let contentView = ContentView(viewModel: viewModel)

        let newVehicle1 = Vehicle(
            color: "Red",
            make: "Toyota",
            model: "Camry",
            parkingSpot: "A1",
            ticketNumber: 0,
            arrivalDate: Date(),
            amountPayed: 0.0
        )

        let newVehicle2 = Vehicle(
            color: "Blue",
            make: "Honda",
            model: "Civic",
            parkingSpot: "C3",
            ticketNumber: 0,
            arrivalDate: Date(),
            amountPayed: 0.0
        )

        contentView.addNewVehicle(newVehicle1)
        contentView.addNewVehicle(newVehicle2)

        XCTAssertEqual(contentView.viewModel.ticketList[0].ticketNumber, 1)
        XCTAssertEqual(contentView.viewModel.ticketList[1].ticketNumber, 2)
    }


    
}
