//
//  UsersResponse.swift
//  People
//
//  Created by Manyuchi, Carrington C on 2025/03/22.
//

import Foundation


// MARK: - UsersResponse
struct UsersResponse: Codable {
    let page, perPage, total, totalPages: Int
    let data: [User]
    let support: Support
}
