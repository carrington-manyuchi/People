//
//  PeopleViewModel.swift
//  People
//
//  Created by Manyuchi, Carrington C on 2025/03/23.
//

import Foundation
// The reason for marking this class as final it is because we do not want any other class to be able to subclass this PeopleViewModel
// The View Job is essentially to listen to this ViewModel for updates and reflect that data.
// The View Model just handles the business logic and allow the view to listen to any changes.
// In SwiftUI we us Observable object protocol


// Thread: set of executions executed oon it.
// Synchronous: Set of instructions executed one after another
// Asynchronous: Code you must wait for to finish

final class PeopleViewModel: ObservableObject {
    @Published private(set) var users: [User] = []
    
    func fetchUsers() {
        NetworkingManager.shared.request("https://reqres.in/api/users", type: UsersResponse.self) { [] res in
            DispatchQueue.main.async {
                switch res {
                case .success(let response):
                    self.users = response.data
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
