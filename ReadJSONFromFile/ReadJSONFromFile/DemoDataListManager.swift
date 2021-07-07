//
//  DemoDataListManager.swift
//  ReadJSONFromFile
//
//  Created by Aditi Agrawal on 07/07/21.
//

import Foundation

import Foundation

class DemoDataListManager {
    
    func fetchDemoDataList(success: @escaping ([DemoData]) -> (), failure: @escaping (String) -> ()) {
        if let localData = self.readLocalFile(forName: "dataList") {
            let demoData = self.parse(jsonData: localData)
            demoData != nil ? success(demoData!) : failure("Oops! Something went wrong.")
        }
    }
    
    
    // MARK: - Private
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print("JSON Read Error:\(error.localizedDescription)")
        }
        return nil
    }
    
    private func parse(jsonData: Data) -> [DemoData]? {
        do {
            let decodedData = try JSONDecoder().decode([DemoData].self,
                                                       from: jsonData)
            return decodedData
        } catch {
            print("JSON Parse error: \(error.localizedDescription)")
            return nil
        }
    }
}
