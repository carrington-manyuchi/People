//
//  ContentView.swift
//  People
//
//  Created by Manyuchi, Carrington C on 2025/03/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .padding()
                .onAppear {
                    print(" 👇🏻 Users response")
                    do {
                        let usersResponse = try StaticJSONMapper.decode(file: "UserStaticData", type: UsersResponse.self)
                        dump(usersResponse)
                        
                        print(" 👇🏻 Single User response")
                        let singleUsersResponse = try StaticJSONMapper.decode(file: "SingleUserData", type: UserDetailResponse.self)
                        dump(singleUsersResponse)
                        
                    }  catch {
                        print("Error decoding JSON: \(error)")
                    }
                    
                }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
