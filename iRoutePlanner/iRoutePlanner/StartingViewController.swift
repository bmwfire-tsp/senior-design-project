//
//  StartingViewController.swift
//  iRoutePlanner
//
//  Created by Brandon Wong on 4/15/19.
//  Copyright © 2019 BMW Fire. All rights reserved.
//

import UIKit

class StartingViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userInput.delegate = self
        configureTapGesture()
    }
    
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        userInput.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (userInput.text != "") {
            sendToNextViewController(self)
        }
        return true
    }
    
    
    @IBAction func sendToNextViewController(_ sender: Any) {
        if (userInput.text != "") {
            performSegue(withIdentifier: "start", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ViewController
        
        vc.startingLocation = userInput.text!
    }
    
}
