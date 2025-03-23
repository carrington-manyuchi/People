//
//  PeopleView.swift
//  People
//
//  Created by Manyuchi, Carrington C on 2025/03/22.
//

import SwiftUI

struct PeopleView: View {
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    @StateObject private var viewModel = PeopleViewModel()
    @State private var shouldShowCreate = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                background
                ScrollView {
                    LazyVGrid(
                        columns: columns,
                        spacing: 20) {
                            ForEach(viewModel.users, id: \.id) { user in
                                NavigationLink {
                                    DetailView(userId: user.id)
                                } label: {
                                    PersonItemView(user: user)
                                }
                            }
                        }
                        .padding()
                }
            }
            .navigationTitle("People")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    create
                }
            }
            .onAppear {
                viewModel.fetchUsers()
            }
            .sheet(isPresented: $shouldShowCreate) {
                CreateView()
            }
        }
    }
}

#Preview {
    PeopleView()
}

private extension PeopleView {
    var background: some View {
        Theme.background
            .ignoresSafeArea(edges: .top)
    }
    
    var create: some View {
        Button {
            shouldShowCreate.toggle()
        } label: {
            Symbols.plus
                .font(
                    .system(.headline, design: .rounded)
                    .bold()
                )
        }
    }
}
