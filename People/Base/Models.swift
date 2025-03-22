//
//  Models.swift
//  People
//
//  Created by Manyuchi, Carrington C on 2025/03/22.
//

import Foundation

// MARK: - User
struct User: Codable {
    let id: Int
    let email, firstName, lastName: String
    let avatar: String
}

// MARK: - Support
struct Support: Codable {
    let url: String
    let text: String
}
