//
//  HTTPRequest.swift
//
//  "https://maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&key=AIzaSyBph9FtyDmDvZqBFuh00noX-kfgI4bhU7I"
//
//  Created by Guest Code User on 3/2/19.
//

import Foundation

func getETA(address1: String, address2: String) -> Int {
    var _ = false
    
    let url = URL(string: "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=Washington,DC&destinations=New+York+City,NY&key=AIzaSyBph9FtyDmDvZqBFuh00noX-kfgI4bhU7I")!
    let task:URLSessionDataTask = URLSession.shared.dataTask(with: url) {(data, response, error) in
        guard let data = data else {return}
        let result = String(data: data, encoding: .utf8)!
        print(result)
        print(readString(result))
    }
    
    while(true) {
        task.resume()
    }
    
    return 0
}

func readString(_ input: String) -> Int {
    var pointer = input.startIndex
    var hours: Int
    var minutes: Int
    var manipulateString = input
    var result = -1
    
    for i in 0..<input.count - 7 {
        print(i)
        print(input[pointer..<input.index(pointer, offsetBy: 8)])
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
    return result
}

let input = """
{
"destination_addresses" : [ "New York, NY, USA" ],
"origin_addresses" : [ "Washington, DC, USA" ],
"rows" : [
{
"elements" : [
{
"distance" : {
"text" : "225 mi",
"value" : 361957
},
"duration" : {
"text" : "3 hours 51 mins",
"value" : 13840
},
"status" : "OK"
}
]
}
],
"status" : "OK"
}
"""
print(getETA(address1: "doesn't", address2: "matter"))
