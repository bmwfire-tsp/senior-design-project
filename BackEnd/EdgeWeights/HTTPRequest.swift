//
//  HTTPRequest.swift
//
//  "https://maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&key=AIzaSyBph9FtyDmDvZqBFuh00noX-kfgI4bhU7I"
//
//  Created by Guest Code User on 3/2/19.
//

import Foundation

let apiKey = "AIzaSyCrjARni6M94n5tNwj6SnsX-qdRNKEWVvk"
func getETA(origin: String, destination: String) -> Int {
    var result: String = "" 
    let modOrigin = origin.replacingOccurrences(of: " ", with: "+")
    let modDestination = destination.replacingOccurrences(of: " ", with: "+")
 
    let url = URL(string: "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=" + modOrigin + "&destinations=" + modDestination + "&key=" + apiKey)!
    
    let task:URLSessionDataTask = URLSession.shared.dataTask(with: url) {(data, response, error) in
        guard let data = data else {return}
        result = String(data: data, encoding: .utf8)!
    }
    
    while(result == "") {
        task.resume()
    }
    task.cancel()
    
    return readString(result)    
}

func readString(_ input: String) -> Int {
    var pointer = input.startIndex
    var manipulateString = input
    
    for _ in 0..<input.count - 7 {
        if (input[pointer..<input.index(pointer, offsetBy: 8)] == "duration") {
            while (input[pointer..<input.index(pointer, offsetBy: 1)] != "v") {
                pointer = input.index(pointer, offsetBy: 1)
            }
            manipulateString.removeSubrange(manipulateString.startIndex..<pointer)
            pointer = manipulateString.startIndex
            var num: Int? = Int(manipulateString[pointer..<manipulateString.index(pointer, offsetBy: 1)])
            while(num == nil) {
                pointer = input.index(pointer, offsetBy: 1)
                num = Int(manipulateString[pointer..<manipulateString.index(pointer, offsetBy: 1)])
            }
            manipulateString.removeSubrange(manipulateString.startIndex..<pointer)
            return Int(manipulateString[manipulateString.startIndex..<manipulateString.firstIndex(of: "\n")!])!
        }
        pointer = input.index(after: pointer)
    }
    return -1 
}

let start = "717 Paani St, Honolulu, HI"
let end = ",98-675 Papalealii St, Aiea, HI"
print(getETA(origin: start, destination: end))
