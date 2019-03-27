//
//  GetEdgeWeight.swift
//  iRoutePlanner
//
//  Created by Ryuto Kitagawa on 3/7/19.
//  Copyright © 2019 BMW Fire. All rights reserved.
//

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
