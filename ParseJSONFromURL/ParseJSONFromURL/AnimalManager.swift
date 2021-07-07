//
//  AnimalManager.swift
//  ParseJSONFromURL
//
//  Created by Aditi Agrawal on 07/07/21.
//

import Foundation

class AnimalManager {
    
    func fetchAnimals(success: @escaping ([AnimalData]) -> (), failure: @escaping (String) -> ()) {
        
        let urlString = "https://raw.githubusercontent.com/programmingwithswift/ReadJSONFileURL/master/hostedDataFile.json"
        
        self.loadJson(fromURLString: urlString) { (result) in
            switch result {
            case .success(let data):
                let animals = self.parse(jsonData: data)
                animals != nil ? success(animals!) : failure("Oops! Something went wrong.")
            case .failure(let error):
                print(error)
                failure(error.localizedDescription)
            }
        }
    }
    
    private func loadJson(fromURLString urlString: String,
                          completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                
                if let data = data {
                    completion(.success(data))
                }
            }
            urlSession.resume()
        }
    }
    
    private func parse(jsonData: Data) -> [AnimalData]? {
        do {
            let decodedData = try JSONDecoder().decode([AnimalData].self,
                                                       from: jsonData)
            return decodedData
        } catch {
            print("decode error")
            return nil
        }
    }
}


