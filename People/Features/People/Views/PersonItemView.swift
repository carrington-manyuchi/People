//
//  PersonItemView.swift
//  People
//
//  Created by Manyuchi, Carrington C on 2025/03/22.
//

import SwiftUI

struct PersonItemView: View {
    let user: Int
    var body: some View {
        VStack(spacing: .zero) {
            Rectangle()
                .fill(Color.blue)
                .frame(height: 130)
            
            VStack(alignment: .leading) {
                PillView(id: user)
                
                Text("Carrington Manyuchi")
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
    PersonItemView(user: 0)
        .frame(width: 250)
}
