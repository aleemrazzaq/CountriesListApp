//
//  CountryService.swift
//  CountriesList
//
//  Created by Aleem on 08/01/2026.
//


import Foundation
import Combine

// MARK: - Enum
enum CountryServiceError: LocalizedError {
    case invalidResponse(code: Int)
    case decodingFailed
    case networkFailed
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse(let code):
            return "Server returned invalid response (Code: \(code))"
        case .decodingFailed:
            return "Failed to parse data from server"
        case .networkFailed:
            return "Network error. Please check your internet connection."
        }
    }
}

final class CountryService: CountryServiceProtocol {
    
    // MARK: - Properties
    private let url = APIConstant.countriesURL
    private let decoder = JSONDecoder()
    
    // MARK: - Methods
    
    /// Fetches countries from JSON endpoint
    /// - Returns: Publisher emitting `[Country]` or `Error`
    func fetchCountries() -> AnyPublisher<[Country], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse else {
                    throw CountryServiceError.networkFailed
                }
                guard 200..<300 ~= response.statusCode else {
                    throw CountryServiceError.invalidResponse(code: response.statusCode)
                }
                return output.data
            }
            .decode(type: [Country].self, decoder: decoder)
            .mapError { error -> CountryServiceError in
                if error is DecodingError {
                    return .decodingFailed
                } else if let serviceError = error as? CountryServiceError {
                    return serviceError
                } else {
                    return .networkFailed
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    // MARK: - Private Methods
    
    /// Validates HTTP response and returns data if valid
    /// - Parameter output: URLSession.DataTaskPublisher.Output
    /// - Throws: URLError if response is invalid
    /// - Returns: Data from response
    private func validateResponse(_ output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              200..<300 ~= response.statusCode else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}
