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
        downloadImage()
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
    
    func downloadImage() {
        // Create URL
        let url = URL(string: "https://cdn.cocoacasts.com/cc00ceb0c6bff0d536f25454d50223875d5c79f1/above-the-clouds.jpg")!
        
        DispatchQueue.global().async {
            // Fetch Image Data
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    // Create Image and Update Image View
                    _ = UIImage(data: data)
                }
            }
        }
    }
}

