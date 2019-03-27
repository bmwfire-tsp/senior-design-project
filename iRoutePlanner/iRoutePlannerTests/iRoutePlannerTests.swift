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
        let end = LocationNode(address: "Manoa")
        
        // When: We call the Google Maps API
        
        let weight = getETA(origin: start.address, destination: end.address)
        
        // Then: We should output a valid number
        
        XCTAssertNotNil(weight)
    }
    
    func testNode() {
        
        // Given: A constructed address node
        
        let location = LocationNode(address: "Aiea")
        
        // Then: The value of the address should be accessible
        
        XCTAssertEqual(location.address, "Aiea")
    }
    
//    func testTSP() {
//
//        // Given: A constructed distance matrix and list of addresses
//
//        let d = DistanceMatrix()
//        d.addLocations(locations: [LocationNode(address: "Aiea"), LocationNode(address: "Manoa"), LocationNode(address: "Kalihi"), LocationNode(address: "Mililani"), LocationNode(address: "Honolulu")])
//
//        // When: We call the TSP function
//
//        let t = TSP(locations: d.activeLocations, matrix: d, origin: LocationNode(address: "Aiea"))
//
//        // Then: The output list should be empty
//
//        XCTAssertEqual(t, [])
//    }
    
}
