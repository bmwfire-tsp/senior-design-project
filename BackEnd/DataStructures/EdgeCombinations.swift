//
//  EdgeCombinations.swift
//  
//
//  Created by Brandon Wong on 3/21/19.
//

func edgeComb(locations: [String]) -> [[String]] {
    let n = locations.count
    let k = 2
    var edges = [[Int]]()
    var result = [[String]]()
    
    func combinations(offset: Int, partial: [Int]) {
        if partial.count == k {
            edges.append(partial)
            return
        }
        
        let numRemaining = k - partial.count
        var i = offset
        while i <= n && numRemaining <= n - i + 1 {
            combinations(offset: i + 1, partial: partial + [i])
            i += 1
        }
    }
    
    combinations(offset: 1, partial: [Int]())
    for edge in edges {
        result.append([locations[edge[0] - 1], locations[edge[1] - 1]])
        result.append([locations[edge[1] - 1], locations[edge[0] - 1]])
    }
    return result
}
let locations = ["Aiea", "Manoa", "Kalihi", "Ewa", "Honolulu"]
let edges = edgeComb(locations: locations)
print(locations)
print(edges)
