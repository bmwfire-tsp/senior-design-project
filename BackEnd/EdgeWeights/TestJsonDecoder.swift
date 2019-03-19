import Foundation

let apiKey = "AIzaSyCrjARni6M94n5tNwj6SnsX-qdRNKEWVvk" 

func parseJSON() {
    let modOrigin = "Hello" 
    let modDestination = "There" 

    let url = URL(string: "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=" + modOrigin + "&destinations=" + modDestination + "&key=" + apiKey)!

    let task:URLSessionDataTask = URLSession.shared.dataTask(with: url) {(data, response, error) in
        guard let dataResponse = data else {return}
        do {
            let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
            guard let jsonDic = jsonResponse as? [String: Any] else {return} 
            let element = jsonDic["rows"] as! NSArray 
            let this = element[0] as! NSDictionary
            print(this["element"]) 
        } catch let parsingError {
            print("Error", parsingError)
        } 
    }

    while(true) {
        task.resume()
    }
    task.cancel()

}

parseJSON()

