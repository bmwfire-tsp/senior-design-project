import Foundation

let apiKey = "AIzaSyCrjARni6M94n5tNwj6SnsX-qdRNKEWVvk"

func getETA(origin: String, destination: String) -> NSInteger {
    let modOrigin = origin.replacingOccurrences(of: " ", with: "+")
    let modDestination = destination.replacingOccurrences(of: " ", with: "+")
    var value: NSInteger = -2
    
    let url = URL(string: "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=" + modOrigin + "&destinations=" + modDestination + "&key=" + apiKey)!
    
    let task:URLSessionDataTask = URLSession.shared.dataTask(with: url) {(data, response, error) in
        guard let dataResponse = data else {value = -1; return}
        do {
            let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
            guard let jsonDic = jsonResponse as? [String: Any] else {value = -1; return}
            if ((jsonDic["status"] as! String) == "OK") {
                let elements = jsonDic["rows"] as! NSArray
                let next = elements[0] as! NSDictionary
                let nextElements = next["elements"] as! NSArray
                let nextDur = nextElements[0] as! NSDictionary
                if ((nextDur["status"] as! String) == "OK") {
                    let duration = nextDur["duration"] as! NSDictionary
                    value = duration["value"] as! NSInteger
                } else { value = -1 }
            } else { value = -1 }
        } catch let parsingError {
            print("Error", parsingError)
        }
    }
    
    while(value == -2) {
        task.resume()
    }
    
    task.cancel()
    return value
}

protocol ShakaNode: Hashable {
    var address: String { get }
}

struct LocationNode: ShakaNode {
    var address: String
}

protocol ShakaEdgeAdapter {
    // Metric doesn't need to be specified since duration is hard coded
    func getEdgeWeight(source: LocationNode, dest: LocationNode) -> NSInteger
}

class GoogleEdgeAdapter: ShakaEdgeAdapter {
    func getEdgeWeight(source: LocationNode, dest: LocationNode) -> NSInteger {
        return getETA(origin: source.address, destination: dest.address)
    }
}

//class TestEdgeAdapter: ShakaEdgeAdapter {
//    func getEdgeWeight(source: LocationNode, dest: LocationNode, metric: String) -> Float {
//        return Float.random(in: 2 ..< 10)
//    }
//}

protocol ShakaDistanceMatrix {
    func addLocations(locations: Set<LocationNode>)
    func getEdgeWeight(source: LocationNode, dest: LocationNode) -> NSInteger
    func updateEdgeWeight(source: LocationNode, dest: LocationNode)
    func updateEdgeWeights(locations: Set<LocationNode>)
    func refreshEdgeWeights()
    func removeLocation(location: LocationNode)
    func removeLocations(locations: Set<LocationNode>)
}

class DistanceMatrix: ShakaDistanceMatrix {
    var matrix: [LocationNode: [LocationNode: NSInteger]] = [:]
    var activeLocations: Set<LocationNode> = []
    let edgeAdapter: ShakaEdgeAdapter
    
    
    init(edgeAdapter: ShakaEdgeAdapter = GoogleEdgeAdapter()) {
        self.edgeAdapter = edgeAdapter
    }
    
    public func addLocations(locations: Set<LocationNode>) {
        updateEdgeWeights(locations: locations)
    }
    
    public func getEdgeWeight(source: LocationNode, dest: LocationNode) -> NSInteger {
        return matrix[source]![dest]!
    }
    
    public func updateEdgeWeight(source: LocationNode, dest: LocationNode) {
        if (!matrix.keys.contains(source)) {
            matrix[source] = [:]
        }
        
        matrix[source]![dest] = edgeAdapter.getEdgeWeight(source: source, dest: dest)
    }
    
    public func updateEdgeWeights(locations: Set<LocationNode>) {
        activeLocations = activeLocations.union(Set(locations))
        for location in locations {
            for activeLocation in activeLocations {
                updateEdgeWeight(source: location, dest: activeLocation)
                updateEdgeWeight(source: activeLocation, dest: location)
            }
        }
        return
    }
    
    public func refreshEdgeWeights() {
        updateEdgeWeights(locations: activeLocations)
    }
    
    public func removeLocation(location: LocationNode) {
        removeLocations(locations: Set([location]))
    }
    
    public func removeLocations(locations: Set<LocationNode>) {
        activeLocations = activeLocations.subtracting(locations)
    }
}

var d = DistanceMatrix()

d.addLocations(locations: [LocationNode(address: "Aiea"), LocationNode(address: "UH Manoa")])
print(d.getEdgeWeight(source: LocationNode(address: "Aiea"), dest: LocationNode(address: "UH Manoa")))
