# Edge Adapter

## Interface

## protocol ShakaEdgeAdapter

**Description:**
Multiple interfaces will provide functionality to retrieve map information (Google Maps, Apple Maps, etc.) but contain incompatible interfaces to one another. To ammend this problem, this protocol utilizes the Adapter pattern to create one reliable interface for handling edge weights.

**Methods:**
- getEdgeWeight(source: ShakaNode, dest: ShakaNode, metric: String) => Float
  - **Parameters:**
    - source: ShakaNode => Source of the directed edge
    - dest: ShakaNode => Destination of the directed edge 
    - metric: String => The metric to use for the weight of the directed edge (time, distance, etc.)
  - **Returns:**
    - A float corresponding to the weight of the directed edge. Should be based on the metric specified.
  - **Description:**
    - The implementation should return an edge weight from the source to the destination using the appropriate metric. Metric may conform to whatever is available for the implementation but should be documented as an available keyword


## Implementation

### class GoogleMapsEdgeAdapter
**Description:** Google Maps API for edge weights

### class AppleMapsEdgeAdapter
**Description:** Apple Maps API for edge weights