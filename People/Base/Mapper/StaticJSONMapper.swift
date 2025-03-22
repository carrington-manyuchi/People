//
//  StaticJSONMapper.swift
//  People
//
//  Created by Manyuchi, Carrington C on 2025/03/22.
//

import Foundation

struct StaticJSONMapper {
    
    static func decode<T: Decodable>(file: String, type: T.Type) throws -> T {
        guard let path = Bundle.main.path(forResource: file, ofType: "json"),
                let data = FileManager.default.contents(atPath: path) else {
            throw MappingError.failedToGetContents
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let result = try decoder.decode(T.self, from: data)
        return result
    }
}


extension StaticJSONMapper {
    enum MappingError: Error {
        case failedToGetContents
    }
}
