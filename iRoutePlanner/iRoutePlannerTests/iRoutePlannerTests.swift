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
    
    func testDistanceMatrix() {
        
        // Given: A constructed distance matrix and a set of locations
        
        let d = DistanceMatrix()
        let addresses: Set = [LocationNode(address: "Aiea"), LocationNode(address: "Manoa"), LocationNode(address: "Kalihi"), LocationNode(address: "Honolulu")]
        
        // When: We add locations to the distance matrix
        
        d.addLocations(locations: addresses)
        
        // Then: There should be 4 valid addresses in the activeLocations
        
        XCTAssertEqual(d.activeLocations.count, 4)
        
        // When: We remove a location from the activeLocations
        
        d.removeLocation(location: LocationNode(address: "Kalihi"))
        
        // Then: There will be 3 valid addresses
        
        XCTAssertEqual(d.activeLocations.count, 3)
        
        // When: We call an edge weight from the distance matrix
        
        let weight = d.getEdgeWeight(source: LocationNode(address: "Manoa"), dest: LocationNode(address: "Honolulu"))
        
        // Then: we will receive a valid edge weight
        
        XCTAssertNotEqual(weight, -1)
    }
    
    func testPermutations() {
        
        // Given: A list of values
        
        let list = [1, 2, 3, 4, 5]
        
        // When: We call permutations on the list
        
        let perm = permutations(locations: list)
        
        // Then: We'll have 5! permutations
        
        XCTAssertEqual(perm.count, 120)
    }
    
    func testTSP() {

        // Given: A constructed distance matrix and list of addresses

        let d = DistanceMatrix()
        let start = LocationNode(address: "Wahiawa")
        let addresses: Set = [LocationNode(address: "Wahiawa"), LocationNode(address: "Aiea"), LocationNode(address: "Manoa"), LocationNode(address: "Kalihi"), LocationNode(address: "Honolulu")]

        // When: We add the addresses to the distance matrix
        
        d.addLocations(locations: addresses)
        
        // When: We call the TSP function

        let t = TSP(locations: d.activeLocations, matrix: d, origin: start)

        // Then: There should be 4 valid addresses returned

        print(t)
        XCTAssertEqual(t.count, 4)
    }
    
}
