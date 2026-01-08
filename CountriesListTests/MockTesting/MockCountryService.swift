//
//  MockCountryService.swift
//  CountriesList
//
//  Created by Aleem on 08/01/2026.
//


import Foundation
import Combine
@testable import CountriesList

// MARK: - Mock Country Service

final class MockCountryService: CountryServiceProtocol {
    
    // MARK: - Properties
    var result: Result<[Country], Error>?
    
    // MARK: - Methods
    func fetchCountries() -> AnyPublisher<[Country], Error> {
        
        guard let result else {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        }
        
        switch result {
        case .success(let countries):
            return Just(countries)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
            
        case .failure(let error):
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
}
