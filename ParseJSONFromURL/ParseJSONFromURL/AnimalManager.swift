//
//  AnimalManager.swift
//  ParseJSONFromURL
//
//  Created by Aditi Agrawal on 07/07/21.
//

import Foundation

class AnimalManager {
    
    func fetchAnimals(success: @escaping ([AnimalData]) -> (), failure: @escaping (String) -> ()) {
        
        let urlString = "https://elephant-api.herokuapp.com/elephants"
        
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
            
            let task = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                
                if let error = error {
                    completion(.failure(error))
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print("Error with the response, unexpected status code: \(String(describing: response))")
                    return
                }
                
                if let data = data {
                    completion(.success(data))
                }
            }
            task.resume()
        }
    }
    
    private func parse(jsonData: Data) -> [AnimalData]? {
        do {
            let decodedData = try JSONDecoder().decode([AnimalData].self,
                                                       from: jsonData)
            return decodedData
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}


