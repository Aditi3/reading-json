//
//  DemoDataService.swift
//  ReadJSONFromFile
//
//  Created by Aditi Agrawal on 06/07/21.
//

import Foundation

class DemoDataManager {
    
    func fetchDemoData(success: @escaping (DemoData) -> (), failure: @escaping (String) -> ()) {
        if let localData = self.readLocalFile(forName: "data") {
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
    
    private func parse(jsonData: Data) -> DemoData? {
        do {
            let decodedData = try JSONDecoder().decode(DemoData.self,
                                                       from: jsonData)
            print("Title: ", decodedData.title)
            print("Description: ", decodedData.description)
            print("Image URL: ", decodedData.image)
            print("===================================")
            return decodedData
        } catch {
            print("JSON Parse error: \(error.localizedDescription)")
            return nil
        }
    }
}
