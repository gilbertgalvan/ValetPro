//
//  Valet_ProTests.swift
//  Valet ProTests
//
//  Created by Gilbert Galvan on 12/5/23.
//

import XCTest
@testable import Valet_Pro

final class Valet_ProTests: XCTestCase {

    func testVehicleInitialization() {
        let arrivalDate = Date()
        let vehicle = Vehicle(color: "Red", make: "Toyota", model: "Camry", parkingSpot: "A1", ticketNumber: 1, arrivalDate: arrivalDate, amountPayed: 0.0)

        XCTAssertEqual(vehicle.color, "Red")
        XCTAssertEqual(vehicle.make, "Toyota")
        XCTAssertEqual(vehicle.model, "Camry")
        XCTAssertEqual(vehicle.parkingSpot, "A1")
        XCTAssertEqual(vehicle.ticketNumber, 2) // Check if ticketNumber is incremented correctly
        XCTAssertEqual(vehicle.arrivalDate, arrivalDate)
        XCTAssertEqual(vehicle.amountPayed, 0.0)
        }
    
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
    
    
    
}
