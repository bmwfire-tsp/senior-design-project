//
//  TSP.swift
//  iRoutePlanner
//
//  Created by Brandon Wong on 3/27/19.
//  Copyright © 2019 BMW Fire. All rights reserved.
//

import Foundation

func permutations(locations: [Int]) -> [[Int]] {
    var result = [[Int]]()
    
    func permute(_ addresses: [Int], _ length: Int) {
        if length == 0 {
            result.append(addresses)
        } else {
            var addresses = addresses
            permute(addresses, length - 1)
            for i in 0..<length {
                addresses.swapAt(i, length)
                permute(addresses, length - 1)
                addresses.swapAt(i, length)
            }
        }
    }
    permute(locations, locations.count - 1)
    return result
}

func TSP(locations: Set<LocationNode>, matrix: DistanceMatrix, origin: LocationNode) -> [LocationNode] {
    
    // Check if locations is empty
    if locations.count == 0 {
        return []
    }
    
    // Cast locations to type array
    let locations = [LocationNode](locations)

    // Create a map of locations apart from origin
    var map = [Int: LocationNode]()
    var source = Int()
    for i in 0..<locations.count {
        if locations[i] != origin {
            map[i] = locations[i]
        } else {
            source = i
        }
    }

    // Build array from map keys
    var vertex = [Int]()
    for m in map {
        vertex.append(m.key)
    }

    // Remove origin node from activeLocations
    matrix.removeLocation(location: origin)

    // Build graph
    var graph = [[NSInteger]]()
    var subGraph = [NSInteger]()

    for location in locations {
        for i in 0..<locations.count {
            subGraph.append(matrix.getEdgeWeight(source: location, dest: locations[i]))
        }
        graph.append(subGraph)
        subGraph = [NSInteger]()
    }

    // Modified TSP Algorithm
    var minPath = Double.infinity
    var result = [LocationNode]()
    for perm in permutations(locations: vertex) {
        var tempResult = [LocationNode]()
        var current = 0
        var k = source
        for i in 0..<perm.count {
            current += graph[k][perm[i]]
            k = perm[i]
            tempResult.append(map[perm[i]]!)
        }

        if Double(current) < minPath {
            result = tempResult
            minPath = Double(current)
        }
    }

    return result
}
