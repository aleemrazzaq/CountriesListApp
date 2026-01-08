//
//  CountriesViewModel.swift
//  CountriesList
//
//  Created by Aleem on 08/01/2026.
//


import Foundation
import Combine

final class CountriesViewModel: ObservableObject {

    // MARK: - Properties
    @Published private(set) var countries: [Country] = []
    @Published private(set) var isLoading = false
    @Published var errorMessage: String?
    @Published var toastMessage: String?

    private let service: CountryServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Methods
    init(service: CountryServiceProtocol = CountryService()) {
        self.service = service
    }

    func loadCountries() {
        isLoading = true
        errorMessage = nil
        
        service.fetchCountries()
            .receive(on: DispatchQueue.main) // important for tests
            .sink { [weak self] completion in
                self?.isLoading = false
                
                switch completion {
                case .finished:
                    break
                    
                case .failure(let error):
                    if let urlError = error as? URLError {
                        switch urlError.code {
                        case .notConnectedToInternet:
                            self?.errorMessage = "No internet connection. Please check your network."
                        case .badServerResponse:
                            self?.errorMessage = "Server returned an invalid response."
                        default:
                            self?.errorMessage = "Unable to load countries. Please try again."
                        }
                    } else {
                        self?.errorMessage = "Unable to load countries. Please try again."
                    }
                }
            } receiveValue: { [weak self] countries in
                self?.countries = countries
            }
            .store(in: &cancellables)

    }


    
    private func hideToastLater() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.toastMessage = nil
        }
    }

}
