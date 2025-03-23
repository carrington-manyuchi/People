//
//  CreateView.swift
//  People
//
//  Created by Manyuchi, Carrington C on 2025/03/22.
//

import SwiftUI

struct CreateView: View {
    
    @Environment(\.dismiss) private   var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                firstName
                lastName
                job
                
                Section {
                    submitButton
                }
            }
            .navigationTitle("Create")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    done
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CreateView()
    }
}

private extension CreateView {
    var background: some View {
        Theme
            .background
            .ignoresSafeArea(edges: .top)
    }
}

private extension CreateView {
    var firstName: some View {
        TextField("First Name", text: .constant(""))
    }
    
    var lastName: some View {
        TextField("Last Name", text: .constant(""))
    }
    
    var job: some View {
        TextField("Job", text: .constant(""))
    }
    
    var submitButton: some View {
            Button("Submit") {
                // TODO: Handle action
            }
    }
    
    var done: some View {
        Button("Done") {
            dismiss()
        }
    }
}
