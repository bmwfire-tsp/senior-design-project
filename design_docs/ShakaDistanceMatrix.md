# Distance Matrix
The Distance Matrix is an efficient data structure for fast lookups of edge weights and potential parallelization of edge recomputations. Efficient removal of locations for the application's use case can be made through an additional Hash Table.

## Interface

### protocol ShakaDistanceMatrix

**Methods:**
- public addLocations(locations: Array[ShakaNode])
  - **Parameters:**
    - locations: Array[ShakaNode] -> New location(s) to be added
  - **Description:**
    - A list of locations will be added to the ShakaDistanceMatrix with their appropriate edge weights added for all entries as well
- public getEdgeWeight(source: ShakaNode, dest: ShakaNode) => Float
  - **Parameters:**
    - source: ShakaNode -> Source node
    - dest: ShakaNode -> Destination node
  - **Returns:**
    - Edge weight from source to destination
  - **Description:**
    - Get a single distance (edge weight) from source to destination.
- public removeLocations(locations: Array[ShakaNode])
  - **Parameters:**
    - locations: Array[ShakaNode] -> Location(s) to be removed
  - **Description:**
    - Remove locations from the ShakaDistanceMatrix
- public updateEdgeWeight(source: ShakaNode, dest: ShakaNode)
  - **Parameters:**
    - source: ShakaNode -> Source node
    - dest: ShakaNode -> Destination node
  - **Description:**
    - The edge (source, dest) will have its edge weight updated.
- public updateEdgeWeights(locations: Array[ShakaNode])
  - **Parameters:**
    - locations: Array[ShakaNode] -> Location(s) to have their related edge weight(s) updated.
  - **Description:**
    - All edges with either source or dest corresponding to a location in locations will have their edge weights updated.
- public isEmpty() => Boolean
  - **Returns:**
    - True if there are no more locations to visit.
  - **Description:**
    - Returns whether or not there are locations that still need to be visited. Implementation will need to somehow keep track of this.


## Implementation

### class DistanceMatrix

**Member Variables:**
- *matrix*: [ShakaNode: [ShakaNode: Float]]
- *activeLocations*: [ShakaNode: Boolean]


**Methods:**
- constructor(locations: Array[ShakaNode])
  - **Parameters:**
    - locations: Array[ShakaNode] -> Initial location(s) to be added into *matrix*
  - **Time Complexity:** $O(V)$
- public addLocations(locations: Array[ShakaNode])
  - **Time Complexity:** $O(V^2)$
- public getEdgeWeight(source: ShakaNode, dest: ShakaNode)
  - **Time Complexity:** $O(1)$
- public removeLocations(locations: Array[ShakaNode])
  - **Description:**
    - Removing columns from *matrix* is expensive. Instead we can nullify the activity of a location in *activeLocations* to avoid recomputations in other methods.
  - **Time Complexity:** $O(1)$ average, $O(V)$ worst (by use case)
- public updateEdgeWeight(source: ShakaNode, dest: ShakaNode)
  - **Time Complexity:** $O(1)$
- public updateEdgeWeights(locations: Array[ShakaNode])
  - **Time Complexity:** $O(V^2)$, theoretically parallelization leads to $O(1)$
