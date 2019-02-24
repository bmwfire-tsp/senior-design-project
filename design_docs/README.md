# Shaka Streets Design Documentation

## Front-End
**Description:** The Front-End should allow the user to input $V$ locations that they want to visit. After the user input is complete, a single list of locations (of type Array[ShakaNode]) should be sent to the Back-End.

## Back-End
**Description:** The Back-End should accept a single list of locations (of type Array[ShakaNode]) and compute the TSP algorithm to find the optimal path for the given locations. Once computed, it should reply to the Front-End with a given subset of the locations (of type Array[ShakaNode]) acknowledging the current order which should be traversed.

### Interface Relationship
- ShakaTSP utilizes ShakaDistanceMatrix to perform the TSP algorithm on a given list of ShakaNodes.
- ShakaDistanceMatrix utilizes ShakaEdgeAdapter to obtain edge weights for each of its entries
- ShakaNode is built by being given an address that should be verified using ShakaAddressAdapter
- ShakaDistanceMatrix is a 2d matrix that utilizes ShakaNodes as the vertices









