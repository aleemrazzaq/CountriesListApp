//
//  CountriesListView.swift
//  CountriesList
//
//  Created by Aleem on 08/01/2026.
//

import SwiftUI

struct CountriesListView: View {
    
    // MARK: - Properties
    @StateObject private var viewModel = CountriesViewModel()
    @State private var showErrorAlert = false
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                
                // Background
                Color(.systemGray6)
                    .edgesIgnoringSafeArea(.all)
                
                content
                    .onChange(of: viewModel.errorMessage) { newValue in
                        showErrorAlert = newValue != nil
                    }
                
                // Toast overlay
                if let toast = viewModel.toastMessage {
                    ToastView(message: toast)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .zIndex(1)
                }
            }
            .animation(.easeInOut, value: viewModel.toastMessage)
            .navigationTitle("Countries List")
            .alert("Failed to load data", isPresented: $showErrorAlert, presenting: viewModel.errorMessage) { error in
                Button("Retry") { viewModel.loadCountries() }
                Button("Cancel", role: .cancel) { }
            } message: { error in
                Text(error)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear { viewModel.loadCountries() }
    }
    
    // MARK: - Content View
    private var content: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Loading Countries...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            }
            else {
                List(viewModel.countries) { country in
                    CountryRowView(country: country)
                        .listRowBackground(Color.white)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .listRowSeparator(.hidden)
                }
                .listStyle(PlainListStyle())
                .background(Color(.systemGray6))
            }
        }
    }
}
