//
//  CountriesViewModelTests.swift
//  CountriesList
//
//  Created by Aleem on 08/01/2026.
//

import XCTest
import Combine
@testable import CountriesList

final class CountriesViewModelTests: XCTestCase {
    
    // MARK: - Properties
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Setup 
    override func tearDown() {
        cancellables.removeAll()
        super.tearDown()
    }
    
    // MARK: - Test: Success Case
    func testSuccessLoadCountries() {
        // Arrange
        let mockService = MockCountryService()
        mockService.result = .success([
            Country(name: "Testland", region: "EU", code: "TS", capital: "Testville")
        ])
        
        let viewModel = CountriesViewModel(service: mockService)
        let expectation = XCTestExpectation(description: "Countries Loaded")
        
        viewModel.$countries
            .dropFirst() // skip initial empty array
            .sink { countries in
                XCTAssertEqual(countries.count, 1, "Expected 1 country")
                XCTAssertEqual(countries.first?.name, "Testland", "Country name mismatch")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.loadCountries()
        wait(for: [expectation], timeout: 2) // slightly longer for async
    }
    
    // MARK: - Test: Failure Case
    func testFailureLoadCountries() {
        
        let mockService = MockCountryService()
        mockService.result = .failure(URLError(.notConnectedToInternet))
        
        let viewModel = CountriesViewModel(service: mockService)
        let expectation = XCTestExpectation(description: "Error Received")
        
        viewModel.$errorMessage
            .compactMap { $0 }          
            .sink { message in
                XCTAssertFalse(message.isEmpty, "Error message should not be empty")
                XCTAssertTrue(message.contains("internet") || message.contains("Unable"),
                              "Error message should be meaningful")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.loadCountries()
        wait(for: [expectation], timeout: 2)
    }



}
