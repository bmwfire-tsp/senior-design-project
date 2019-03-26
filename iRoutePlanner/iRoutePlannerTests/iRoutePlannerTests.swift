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
        // Placeholder for Ryuto's Test
    }
    
    func testNode() {
        
        // Given: A constructed address node
        
        let location = LocationNode(address: "Aiea")
        
        // Then: The value of the address should be accessible
        
        XCTAssertEqual(location.address, "Aiea")
    }
    
}
