//
//  EdgeAdapter.swift
//  iRoutePlanner
//
//  Created by Brandon Wong on 3/25/19.
//  Copyright © 2019 BMW Fire. All rights reserved.
//

import Foundation

protocol EdgeAdapter {
    func getEdgeWeight(source: LocationNode, dest: LocationNode) -> NSInteger
}

class GoogleEdgeAdapter: EdgeAdapter {
    func getEdgeWeight(source: LocationNode, dest: LocationNode) -> NSInteger {
        return getETA(origin: source.address, destination: dest.address)
    }
}
