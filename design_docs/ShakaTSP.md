# Traveling Salesman Algorithm
TSP is used to solve the optimal route between all the nodes within the Distance Matrix. This can be either done by an approximate or complete algorithm depending on input size. Implementations take advantage of the Composite Pattern to choose an appropriate TSP algorithm.

## Interface

### protocol ShakaTSP

**Methods:**
- public compute(locations: Array[ShakaNode], matrix: ShakaDistanceMatrix) => Array[ShakaNode]
  - **Parameters:**
    - locations: Array[ShakaNode] -> Locations to calculate the TSP for.
    - matrix: ShakaDistanceMatrix (optional) -> Distance Matrix with corresponding edge weights for locations. Implementation may already contain an instance of the Distance Matrix making this optional.
  - **Returns:**
    - Array[ShakaNode] -> Optimal path to take based on the calculation of TSP. List should be sorted by order of locations to visit.
  - **Description:**
    - TSP will be computed for the locations given using a Distance Matrix.
<!-- - public nextLocation() => ShakaNode
  - **Description:**
    - TSP Algorithm (approximation or actual depending on size of ShakaDistanceMatrix) will run and return the next ShakaNode that should be visited -->

## Implementation

### class TSPBest
**Description:** Composite class. This should be the main TSP algorithm directly instantiated and all other TSP algorithms should be chosen depending on what is considered the best solution for the given input. 

**Member Variables:**
- matrix: ShakaDistanceMatrix
  
**Methods:**
- constructor(matrix: ShakaDistanceMatrix)
  - **Parameters:**
    - matrix: ShakaDistanceMatrix (optional) -> Distance Matrix with edge weights for locations.


### class TSP
**Description:** Leaf class. Complete solution to the Traveling Salesman Problem.

**Member Variables:**
- matrix: ShakaDistanceMatrix

**Methods:**
- constructor(matrix: ShakaDistanceMatrix)
  - **Parameters:**
    - matrix: ShakaDistanceMatrix (optional) -> Distance Matrix with edge weights for locations.

### class TSPApproxMST
**Description:** Leaf class. Approximate algorithm to the Traveling Salesman Problem. Will utilize a Minimum Spanning Tree to get an approximate solution.


