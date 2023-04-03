//
//  ViewController.swift
//  Noise Control
//
//  Created by Piotr Narecki on 17/03/2023.
//

import UIKit

class MainViewController: UIViewController {

    
    
    @IBOutlet weak var mainLabel: UILabel!
    
    
    @IBOutlet weak var generatorButton: UIButton!
    
    
    @IBOutlet weak var recorderButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainLabel.text="Hello !"
    }
    
    
    @IBAction func generatorPressed(_ sender: UIButton) {
    }
    
    
    @IBAction func recorderPressed(_ sender: UIButton) {
    }
    
    
    
    
    


}

