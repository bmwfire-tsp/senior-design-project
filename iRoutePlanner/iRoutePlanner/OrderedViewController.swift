//
//  OrderedViewController.swift
//  iRoutePlanner
//
//  Created by Guest Code User on 4/14/19.
//  Copyright © 2019 BMW Fire. All rights reserved.
//

import UIKit

class OrderedViewController: UIViewController {
    
    @IBOutlet weak var orderedTable: UITableView!
    
    var orderedArray: [LocationNode] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderedTable.dataSource = self
        orderedTable.delegate = self
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
                let start = orderedArray.remove(at: indexPath.row)

                d.addLocations(locations: addresses)
                let t = TSP(locations: d.activeLocations, matrix: d, origin: start)
                orderedArray = t
                tableView.reloadData()
            } else {
                orderedArray.remove(at: indexPath.row)
                tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationNode = orderedArray[indexPath.row]
        let destianation = destinationNode.address.replacingOccurrences(of: " ", with: "+")
        
        if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!) {
            UIApplication.shared.open(URL(string:"comgooglemaps://?saddr=&daddr=" + destianation)!)
        } else {
            UIApplication.shared.open(URL(string:"https://www.google.com/maps/@42.585444,13.007813,6z")!)
        }
    }
}
