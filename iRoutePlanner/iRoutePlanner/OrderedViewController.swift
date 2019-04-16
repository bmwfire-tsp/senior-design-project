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
    }

}
extension OrderedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = orderedTable.dequeueReusableCell(withIdentifier: "orderedCell", for: indexPath)
        cell.textLabel?.text = orderedArray[indexPath.row].address
        return cell
    }
}
