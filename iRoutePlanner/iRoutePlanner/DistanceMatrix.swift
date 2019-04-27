//
//  DistanceMatrix.swift
//  iRoutePlanner
//
//  Created by Sean Takafuji on 3/25/19.
//  Copyright © 2019 BMW Fire. All rights reserved.
//

import Foundation

protocol Matrix {
    func addLocations(locations: Set<LocationNode>)
    func getEdgeWeight(source: LocationNode, dest: LocationNode) -> NSInteger
    func updateEdgeWeight(source: LocationNode, dest: LocationNode)
    func updateEdgeWeights(locations: Set<LocationNode>)
    func refreshEdgeWeights()
    func removeLocation(location: LocationNode)
    func removeLocations(locations: Set<LocationNode>)
}

class DistanceMatrix: Matrix {
    var matrix: [LocationNode: [LocationNode: NSInteger]] = [:]
    var activeLocations: Set<LocationNode> = []
    let edgeAdapter: EdgeAdapter
    
    
    init(edgeAdapter: EdgeAdapter = GoogleEdgeAdapter()) {
        self.edgeAdapter = edgeAdapter
    }
    
    public func addLocations(locations: Set<LocationNode>) {
        updateEdgeWeights(locations: locations)
    }
    
    public func getEdgeWeight(source: LocationNode, dest: LocationNode) -> NSInteger {
        return matrix[source]![dest]!
    }
    
    public func updateEdgeWeight(source: LocationNode, dest: LocationNode) {
        if (!matrix.keys.contains(source)) {
            matrix[source] = [:]
        }
        
        matrix[source]![dest] = edgeAdapter.getEdgeWeight(source: source, dest: dest)
//        matrix[source]![dest] = (NSInteger)(arc4random() % 42)
    }
    
    public func updateEdgeWeights(locations: Set<LocationNode>) {
        activeLocations = activeLocations.union(Set(locations))
        for location in locations {
            for activeLocation in activeLocations {
                updateEdgeWeight(source: location, dest: activeLocation)
                updateEdgeWeight(source: activeLocation, dest: location)
            }
        }
        return
    }
    
    public func refreshEdgeWeights() {
        updateEdgeWeights(locations: activeLocations)
    }
    
    public func removeLocation(location: LocationNode) {
        removeLocations(locations: Set([location]))
    }
    
    public func removeLocations(locations: Set<LocationNode>) {
        activeLocations = activeLocations.subtracting(locations)
    }
}
