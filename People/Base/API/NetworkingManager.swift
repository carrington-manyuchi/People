//
//  NetworkingManager.swift
//  People
//
//  Created by Manyuchi, Carrington C on 2025/03/23.
//

import Foundation

final class NetworkingManager {
    
    static let shared = NetworkingManager()
    
    private init() {}
    
    func request<T: Codable>(
        methodType: MethodType = .GET,
        _ absoluteURL: String,
        type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        
        guard let url = URL(string: absoluteURL) else {
            completion(.failure(NetworkingError.invalidURL))
            return
        }
        
        let request = buildRequest(from: url, methodType: methodType)
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil {
                completion(.failure(NetworkingError.custom(error: error!)))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200..<300 ~= response.statusCode else {
                let statusCode = (response as! HTTPURLResponse).statusCode
                completion(.failure(NetworkingError.invalidStatusCode(statusCode: statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkingError.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let res = try decoder.decode(T.self, from: data)
                completion(.success(res))
                
            } catch {
                completion(.failure(NetworkingError.failedToDecode(error: error)))
            }
            
        }
        dataTask.resume()
    }
    
    
    func request(
        methodType: MethodType = .POST(data: Data())
        ,
        _ absoluteUrl: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        guard let url = URL(string: absoluteUrl) else {
            completion(.failure(NetworkingError.invalidURL))
            return
        }
        
        let request = buildRequest(from: url, methodType: methodType)
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil {
                completion(.failure(NetworkingError.custom(error: error!)))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200..<300 ~= response.statusCode else {
                let statusCode = (response as! HTTPURLResponse).statusCode
                completion(.failure(NetworkingError.invalidStatusCode(statusCode: statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkingError.invalidData))
                return
            }
            
            completion(.success(()))
            
            
        }
        dataTask.resume()
    }
}

extension NetworkingManager {
    enum NetworkingError: Error, LocalizedError {
        case invalidURL
        case custom(error: Error)
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case failedToDecode(error: Error)
    }
}

extension NetworkingManager.NetworkingError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL is not valid"
        case .custom(error: let err):
            return "Something went wrong \(err.localizedDescription)"
        case .invalidStatusCode:
            return "Status code falls into the wrong range"
        case .invalidData:
            return "Return data is invalid"
        case .failedToDecode:
            return "Failed to decode"
        }
    }
}

extension NetworkingManager {
    enum MethodType {
        case GET
        case POST(data: Data?)
    }
}

private extension NetworkingManager {
    func buildRequest(from url: URL, methodType: MethodType) -> URLRequest {
        var request = URLRequest(url: url)
        
        switch methodType {
        case .GET:
            request.httpMethod = "GET"
        case .POST(let data):
            request.httpMethod = "POST"
            request.httpBody = data
        }
        
        return request
    }
}
