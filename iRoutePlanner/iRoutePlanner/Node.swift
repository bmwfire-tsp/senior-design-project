//
//  Node.swift
//  iRoutePlanner
//
//  Created by Brandon Wong on 3/25/19.
//  Copyright © 2019 BMW Fire. All rights reserved.
//

protocol ShakaNode: Hashable {
    var address: String { get }
}

struct LocationNode: ShakaNode {
    var address: String
}
