//
//  DetailViewmodel.swift
//  People
//
//  Created by Manyuchi, Carrington C on 2025/03/23.
//

import Foundation

final class DetailViewModel: ObservableObject {
    @Published private(set) var userInfo: UserDetailResponse?
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published var hasError = false
    
    
    
    func fetchDetails(for id: Int) {
        NetworkingManager.shared.request("https://reqres.in/api/users/\(id)", type: UserDetailResponse.self) { [weak self] res in
            DispatchQueue.main.async {
                switch res {
                case .success(let response):
                    self?.userInfo = response
                case .failure(let error):
                    print(error)
                    self?.error = error as? NetworkingManager.NetworkingError
                    self?.hasError  = true
                    
                }
            }
        }
    }
    
}
