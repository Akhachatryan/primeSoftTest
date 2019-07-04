//
//  Globals.swift
//  primeSoftTest
//
//  Created by Ashot on 7/3/19.
//  Copyright © 2019 Ashot. All rights reserved.
//

import Foundation
import Alamofire
import CodableAlamofire

// MARK: - User
struct Users: Codable {
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let gender: String
    let name: Name
    let location: Location
    let picture: Picture
}

// MARK: - Location
struct Location: Codable {
    let street, city: String
}

// MARK: - Name
struct Name: Codable {
    let first, last: String
}

// MARK: - Picture
struct Picture: Codable {
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case url = "large"
    }
}

var serverUrl = "https://randomuser.me/api/"

func get(completion: @escaping (Bool)->()) {
    Alamofire.request(serverUrl, method: .get, parameters: nil).validate().responseDecodableObject(keyPath: nil, decoder: JSONDecoder()) { (response: DataResponse<Users>) in
        switch response.result{
        case .success(let data):
            print("true")
            if let imageData = try? Data(contentsOf: URL(string: data.results[0].picture.url)!) {
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        // data.results[0].picture.image
                    }
                }
            }
            //let decoder = JSONDecoder()
            //parsedData = decoder.decode(YourStructure.self, from: data)
            //userArray?.append(contentsOf: data)
            //  newsArray = data
            completion(true)
            break
        case .failure(let error):
            print(error)
            completion(false)
            break
        }
    }
}
