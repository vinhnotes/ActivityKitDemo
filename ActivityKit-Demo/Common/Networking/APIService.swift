//
//  APIService.swift
//  ActivityKit-Demo
//
//  Created by vinhvd on 27/09/2022.
//

import Foundation
import SwiftUI

struct APIService: APIServiceProtocol {
    
    func get<T: Decodable>(_ type: T.Type, url: URL?, completion: @escaping(Result<T, APIError>) -> Void) {
        guard let url = url else {
            let error = APIError.requestFailed
            completion(Result.failure(error))
            return
        }
        let task = URLSession.shared.dataTask(with: url) {(data , response, error) in
            
            if let _ = error {
                completion(Result.failure(APIError.requestFailed))
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.apiResponseError(response.statusCode, message: response.description)))
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(type, from: data)
                    completion(Result.success(result))
                } catch {
                    completion(Result.failure(APIError.jsonParsingFailure))
                }
            }
        }

        task.resume()
    }
    
    
    func getLiveScore(url: URL?, completion: @escaping(Result<[Match], APIError>) -> Void) {
        guard let url = url else {
            let error = APIError.requestFailed
            completion(Result.failure(error))
            return
        }
        let task = URLSession.shared.dataTask(with: url) {(data , response, error) in
            if let _ = error {
                completion(Result.failure(APIError.requestFailed))
            } else if  let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.apiResponseError(response.statusCode, message: response.description)))
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let breeds = try decoder.decode([Match].self, from: data)
                    completion(Result.success(breeds))
                } catch {
                    completion(Result.failure(APIError.jsonParsingFailure))
                }
            }
        }

        task.resume()
    }
}
