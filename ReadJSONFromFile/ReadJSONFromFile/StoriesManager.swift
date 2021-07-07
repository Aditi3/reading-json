//
//  DemoDataListManager.swift
//  ReadJSONFromFile
//
//  Created by Aditi Agrawal on 07/07/21.
//

import Foundation

import Foundation

class StoriesManager {
    
    func fetchDemoDataList(success: @escaping ([StoryData]) -> (), failure: @escaping (String) -> ()) {
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
    
    private func parse(jsonData: Data) -> [StoryData]? {
        do {
            let decodedData = try JSONDecoder().decode([StoryData].self,
                                                       from: jsonData)
            return decodedData
        } catch {
            print("JSON Parse error: \(error.localizedDescription)")
            return nil
        }
    }
}
