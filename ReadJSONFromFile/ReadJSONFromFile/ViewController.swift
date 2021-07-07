//
//  ViewController.swift
//  ReadJSONFromFile
//
//  Created by Aditi Agrawal on 06/07/21.
//

import UIKit

class ViewController: UIViewController {
    
    private var demoData: DemoData?
    private var demoDataList: [DemoData]?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        requestDemoData()
        requestDemoDataList()
    }
    
    func requestDemoData() {
        ///[weak self]  ensures that once the completion handler returns some code, the app can release the memory
        DemoDataManager().fetchDemoData { [weak self] (data) in
            /// Do something with the data the completion handler returns
            print(data)
            self?.demoData = data
            /// Reload the view using the main dispatch queue
            DispatchQueue.main.async {
                /// Do something related to UIView
            }
        } failure: { string in
            print(string)
        }
    }
    
    func requestDemoDataList() {
        ///[weak self]  ensures that once the completion handler returns some code, the app can release the memory
        DemoDataListManager().fetchDemoDataList { [weak self] (data) in
            /// Do something with the data the completion handler returns
            self?.demoDataList = data
            for demo in self?.demoDataList ?? [] {
                print(demo.title)
                print(demo.description)
                print(demo.image)
            }
            /// Reload the view using the main dispatch queue
            DispatchQueue.main.async {
                /// Do something related to UIView
            }
        } failure: { string in
            print(string)
        }
    }
}

