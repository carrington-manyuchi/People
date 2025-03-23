//
//  CreateView.swift
//  People
//
//  Created by Manyuchi, Carrington C on 2025/03/22.
//

import SwiftUI

struct CreateView: View {
    
    @Environment(\.dismiss) private   var dismiss
    @StateObject private var createViewModel = CreateViewModel()
    
    
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
            .onChange(of: createViewModel.submissionState) {
                if createViewModel.submissionState == .successful {
                    dismiss()
                }
            }
            .alert(isPresented: $createViewModel.hasError, error: createViewModel.error) { }
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
        TextField("First Name", text: $createViewModel.person.firstName)
    }
    
    var lastName: some View {
        TextField("Last Name", text: $createViewModel.person.lastName)
    }
    
    var job: some View {
        TextField("Job", text: $createViewModel.person.job)
    }
    
    var submitButton: some View {
            Button("Submit") {
                createViewModel.create()
            }
    }
    
    var done: some View {
        Button("Done") {
            dismiss()
        }
    }
}
