//
//  ShakaNode.swift
//  
//
//  Created by Brandon Wong on 3/25/19.
//

protocol ShakaNode: Hashable {
    var address: String { get }
}

struct LocationNode: ShakaNode {
    var address: String
}
