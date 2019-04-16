//
//  ViewController.swift
//  iRoutePlanner
//
//  Created by Brandon Wong on 3/26/19.
//  Copyright © 2019 BMW Fire. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var list: UITableView!
    
    var userInput: [String]! = []
    var startingLocation: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        input.delegate = self
        list.dataSource = self
        configureTapGesture()
    }
    
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        input.resignFirstResponder()
    }
    
    @IBAction func addButton(_ sender: Any) {
        addToArray()
    }
    
    func addToArray() {
        guard let add = input.text else {return}
        input.text = ""
        if add != "" {
            userInput.append(add)
            list.reloadData()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addToArray()
        return true
    }
    
    
    @IBAction func sendToNextViewController(_ sender: Any) {
        performSegue(withIdentifier: "order", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let orderedViewController = segue.destination as! OrderedViewController
        let d = DistanceMatrix()
        let start = LocationNode(address: startingLocation)
        var locationNodeArray: [LocationNode] = [start]
        
        for i in userInput {
            locationNodeArray.append(LocationNode(address: i))
        }
        
        let addresses: Set = Set(locationNodeArray)
        d.addLocations(locations: addresses)
        let t = TSP(locations: d.activeLocations, matrix: d, origin: start)
        orderedViewController.orderedArray = t
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userInput.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = list.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = userInput[indexPath.row]
        return cell
    }
}

