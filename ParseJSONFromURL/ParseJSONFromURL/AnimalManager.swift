//
//  AnimalManager.swift
//  ParseJSONFromURL
//
//  Created by Aditi Agrawal on 07/07/21.
//

import Foundation

enum CustomError: String, Error {
    case invalidResponse = "The response from the server was invalid."
    case invalidData = "The data received from the server was invalid."
    case invalidId = "The endpoint provided is not valid"
}

class AnimalManager {
    
    let urlString = "https://elephant-api.herokuapp.com/elephants"
    
    // MARK: -  Fetch Animals
    
    /// Fetch the Animal Details and returns either Animal Data Model or Failure errorString
    func fetchAnimals(success: @escaping ([AnimalData]) -> (), failure: @escaping (String) -> ()) {
        
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
    
    // MARK: -  Load JSON
    
    /// Read the Animal JSON Data
    ///
    /// - Parameters:
    ///   - Result: returns either data or error
    
    private func loadJson(fromURLString urlString: String,
                          completion: @escaping (Result<Data, Error>) -> Void) {
        
        // Create a URL
        guard let url = URL(string: urlString) else {
            completion(.failure(CustomError.invalidId))
            return
        }
        
        // Give session a task
        let task = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                completion(.failure(CustomError.invalidData))
                return
            }
            
            if let data = data {
                completion(.success(data))
            }
        }
        // Start a task
        task.resume()
    }
    
    // MARK: -  Parsing JSON
    
    /// Parse the Animal JSON Data
    ///
    /// - Parameters:
    ///   - AnimalData: returns animal detail
    
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


