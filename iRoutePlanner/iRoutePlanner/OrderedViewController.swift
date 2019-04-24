//
//  OrderedViewController.swift
//  iRoutePlanner
//
//  Created by Ryuto Kitagawa on 4/14/19.
//  Copyright © 2019 BMW Fire. All rights reserved.
//

import UIKit

class OrderedViewController: UIViewController {
    
    @IBOutlet weak var orderedTable: UITableView!
    
    var orderedArray: [LocationNode] = []
    var startingLocation: LocationNode = LocationNode(address: "nil")
    var back = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderedTable.dataSource = self
        orderedTable.delegate = self
    }

    @IBAction func back(_ sender: Any) {
        back = true
        performSegue(withIdentifier: "back", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if back {
            var addresses: [String] = []
            
            for i in orderedArray {
                addresses.append(i.address)
            }
            
            let viewController = segue.destination as! ViewController
            viewController.start = startingLocation.address
            viewController.userInput = addresses
        }
    }
}

extension OrderedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = orderedTable.dequeueReusableCell(withIdentifier: "orderedCell", for: indexPath)
        cell.textLabel?.text = orderedArray[indexPath.row].address
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if (orderedArray.count > 1) {
                let d = DistanceMatrix()
            
                let addresses: Set = Set(orderedArray)
                startingLocation = orderedArray.remove(at: indexPath.row)

                d.addLocations(locations: addresses)
                let t = TSP(locations: d.activeLocations, matrix: d, origin: startingLocation)
                orderedArray = t
                tableView.reloadData()
            } else {
                orderedArray.remove(at: indexPath.row)
                tableView.reloadData()
            }
        }
    }
    
    @IBAction func navigateButton(_ sender: Any) {
        var googleURL = "https://www.google.com/maps/dir/"
        
        for element in orderedArray {
            googleURL += "/\(element.address)"
        }
        
        UIApplication.shared.open(URL(string: googleURL)!)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationNode = orderedArray[indexPath.row]
        let destination = destinationNode.address.replacingOccurrences(of: " ", with: "+")
        
        UIApplication.shared.open(URL(string:"https://www.google.com/maps/dir/\(startingLocation.address)/\(destination)")!)
    }
}
