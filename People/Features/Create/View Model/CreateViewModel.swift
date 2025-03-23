//
//  CreateViewModel.swift
//  People
//
//  Created by Manyuchi, Carrington C on 2025/03/23.
//

import Foundation

final class CreateViewModel: ObservableObject {
    
    @Published var person = CreateNewPerson()
    @Published private(set) var submissionState: SubmissionState?
    
    func create() {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let data = try? encoder.encode(person)
        
        NetworkingManager.shared.request(methodType: .POST(data: data), "https://reqres.in/api/users") { [weak self] res in
            DispatchQueue.main.async {
                switch res {
                case .success:
                    print("Successfully created")
                    self?.submissionState = .successful
                case .failure(let error):
                    print("Error: \(error)")
                    self?.submissionState = .unsuccessful
                }
            }
        }
    }
}

extension CreateViewModel {
    enum SubmissionState {
        case unsuccessful
        case successful
    }
    
}
