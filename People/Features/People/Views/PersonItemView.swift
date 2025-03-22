//
//  PersonItemView.swift
//  People
//
//  Created by Manyuchi, Carrington C on 2025/03/22.
//

import SwiftUI

struct PersonItemView: View {
    let user: User
    var body: some View {
        VStack(spacing: .zero) {
            AsyncImage(url: .init(string: user.avatar)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 150)
                    .clipped()
            } placeholder: {
                ProgressView()
            }
            
            VStack(alignment: .leading) {
                PillView(id: user.id)
                
                Text("\(user.firstName) \(user.lastName)")
                    .foregroundStyle(Theme.text)
                    .font(
                        .system(.body, design: .rounded)
                    )
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 8)
            .padding(.vertical, 8)
            .background(Theme.detailBackground)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(
            color: Theme.text.opacity(0.1),
            radius: 2,
            x: 0,
            y: 1
        )
    }
}

#Preview {
    
    var previewUser: User {
        let users = try! StaticJSONMapper.decode(file: "UserStaticData", type: UsersResponse.self)
        
        return users.data.first!
    }
    
    PersonItemView(user: previewUser)
        .frame(width: 250)
}
