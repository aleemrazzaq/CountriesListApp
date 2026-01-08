//
//  MockCountryService.swift
//  CountriesList
//
//  Created by Aleem on 08/01/2026.
//


import Combine
@testable import CountriesList

final class MockCountryService: CountryServiceProtocol {

    // MARK: - Properties
    var result: Result<[Country], Error>!

    // MARK: - Methods
    func fetchCountries() -> AnyPublisher<[Country], Error> {
        result.publisher.receive(on: ImmediateScheduler.shared).eraseToAnyPublisher()
    }
}
