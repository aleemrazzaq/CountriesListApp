//
//  CountryServiceProtocol.swift
//  CountriesList
//
//  Created by Aleem on 08/01/2026.
//


import Combine

// MARK: - Service Protocol
protocol CountryServiceProtocol {
    /// Fetches the list of countries
    /// - Returns: Publisher emitting `[Country]` or `Error`
    func fetchCountries() -> AnyPublisher<[Country], Error>
}
