//
//  Node.swift
//  iRoutePlanner
//
//  Created by Sean Takafuji on 3/25/19.
//  Copyright © 2019 BMW Fire. All rights reserved.
//

protocol Node: Hashable {
    var address: String { get }
}

struct LocationNode: Node {
    var address: String
}
