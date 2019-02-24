# Address Adapter
Multiple interfaces will provide functionality to retrieve map information (Google Maps, Apple Maps, etc.) but contain incompatible interfaces to one another. To ammend this problem, this protocol utilizes the Adapter pattern to create one reliable interface for retrieving proper address names.

## Interface

### protocol ShakaAddressAdapter



**Methods:**
- getCompleteAddress(address: String) => Array[String]
  - **Parameters:**
    - address: String -> An address (complete or incomplete) to validate
  - **Returns:**
    - A complete list of addresses that could potentially match the given address.
  - **Description:**
    - The implementation should be able to handle a complete or incomplete address and validate it against a list of real addresses. The returned list should be sorted in order of most likely to least likely (metric is left up to the implementation)


## Implementation

### class GoogleMapsAddressAdapter: ShakaAddressAdapter

### class AppleMapsAddressAdapter: ShakaAddressAdapter