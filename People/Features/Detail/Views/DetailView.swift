//
//  DetailView.swift
//  People
//
//  Created by Manyuchi, Carrington C on 2025/03/22.
//

import SwiftUI

struct DetailView: View {
    
    let userId: Int
    @StateObject private var detailsViewModel = DetailViewModel()
    
    var body: some View {
        ZStack {
            background
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    avatar
                    Group {
                        general
                        link
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 18)
                    .background(Theme.detailBackground, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                .padding()
            }
        }
        .navigationTitle("Details")
        .onAppear {
            detailsViewModel.fetchDetails(for: userId)
        }
        .alert(isPresented: $detailsViewModel.hasError, error: detailsViewModel.error) { }
    }
}

#Preview {
    NavigationStack {
        DetailView(userId: 3)
    }
}

private extension DetailView {
    var general: some View {
            VStack(alignment: .leading, spacing: 18) {
                PillView(id: detailsViewModel.userInfo?.data.id ?? 0)
                Group {
                    firstName
                    lastName
                    email
                }
                .foregroundStyle(Theme.text)
            }
    }
}

private extension DetailView {
    var background: some View {
        Theme.background
            .ignoresSafeArea(edges: .top)
    }
    
    @ViewBuilder
    var avatar: some View {
        if let avatarAbsoluteString = detailsViewModel.userInfo?.data.avatar,
           let avatarUrl = URL(string: avatarAbsoluteString) {
            
            AsyncImage(url: avatarUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)
                    .clipped()
            } placeholder: {
                ProgressView()
            }
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
    }
    
    @ViewBuilder
    var link: some View {
        
        if let supportAbsolteString = detailsViewModel.userInfo?.support.url,
           let supportURL = URL(string: supportAbsolteString),
           let suppportTxt = detailsViewModel.userInfo?.support.text {
            
            Link(destination: supportURL) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(suppportTxt)
                        .foregroundStyle(Theme.text)
                        .font(
                            .system(.body, design: .rounded)
                            .weight(.semibold)
                        )
                    Text(supportAbsolteString)
                }
                Spacer()
                    Symbols
                    .link
                    .font(.system(.title, design: .rounded))
            }
        }
    }
}

private extension DetailView {
    @ViewBuilder
    var firstName: some View {
        Text("First Name")
            .font(
                .system(.body, design: .rounded)
                .weight(.semibold)
            )
        Text(detailsViewModel.userInfo?.data.firstName ?? "-")
            .font(
                .system(.subheadline, design: .rounded)
            )
        Divider()
    }
}

private extension DetailView {
    @ViewBuilder
    var lastName: some View {
        Text("Last Name")
            .font(
                .system(.body, design: .rounded)
                .weight(.semibold)
            )
        Text(detailsViewModel.userInfo?.data.lastName ?? "-")
            .font(
                .system(.subheadline, design: .rounded)
            )
        Divider()
    }
}

private extension DetailView {
    @ViewBuilder
    var email: some View {
        Text("Email")
            .font(
                .system(.body, design: .rounded)
                .weight(.semibold)
            )
        Text(detailsViewModel.userInfo?.data.email ?? "-")
            .font(
                .system(.subheadline, design: .rounded)
            )
    }
}
