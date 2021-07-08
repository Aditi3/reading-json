//
//  ViewController.swift
//  ParseJSONFromURL
//
//  Created by Aditi Agrawal on 07/07/21.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /// Network call
        requestAnimals()
    }
    
    func requestAnimals() {
        
        AnimalManager().fetchAnimals { animals in
            for animal in animals {
                print(animal.name ?? "")
                print(animal.image ?? "")
                print("===================================")
            }
        } failure: { errorString in
            print(errorString)
        }
    }
}

