//
//  iRoutePlannerTests.swift
//  iRoutePlannerTests
//
//  Created by Brandon Wong on 3/26/19.
//  Copyright © 2019 BMW Fire. All rights reserved.
//

import XCTest
@testable import iRoutePlanner

class iRoutePlannerTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testGetETA() {
        
        // Given: Starting and ending locations
        
        let start = LocationNode(address: "Aiea")
        let middle = LocationNode(address: "Manoa")
        let end = LocationNode(address: "Kalihi")
        
        // When: We call the Google Maps API
        
        let weightStart = getETA(origin: start.address, destination: middle.address)
        let weightMiddle = getETA(origin: middle.address, destination: end.address)
        let weightEnd = getETA(origin: end.address, destination: start.address)
        
        // Then: We should output a valid number
        
        print(weightStart)
        print(weightMiddle)
        print(weightEnd)
        
        // Then: We should output a valid number
        
        XCTAssertNotEqual(weightStart, -1)
        XCTAssertNotEqual(weightMiddle, -1)
        XCTAssertNotEqual(weightEnd, -1)
    }
    
    func testNode() {
        
        // Given: A constructed address node
        
        let location = LocationNode(address: "Aiea")
        
        // Then: The value of the address should be accessible
        
        XCTAssertEqual(location.address, "Aiea")
    }
    
    func testTSP() {

        // Given: A constructed distance matrix and list of addresses

        let d = DistanceMatrix()
        d.addLocations(locations: [LocationNode(address: "Aiea"), LocationNode(address: "Manoa"), LocationNode(address: "Kalihi"), LocationNode(address: "Honolulu")])

        // When: We call the TSP function

        let t = TSP(locations: d.activeLocations, matrix: d, origin: LocationNode(address: "Wahiawa"))

        // Then: There should be 5 valid elements in activeLocations and output list should be empty

        XCTAssertEqual(d.activeLocations.count, 4)
        XCTAssertEqual(t, [])
    }
    
}
