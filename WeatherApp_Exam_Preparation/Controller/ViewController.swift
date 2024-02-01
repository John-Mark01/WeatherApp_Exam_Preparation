//
//  ViewController.swift
//  WeatherApp_Exam_Preparation
//
//  Created by John-Mark Iliev on 1.02.24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var weatherPicture: UIImageView!
    @IBOutlet weak var tempretureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    var apiKey = "fca2cd5933142256e59d27086ecc9d29"
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        
        
    }
}

