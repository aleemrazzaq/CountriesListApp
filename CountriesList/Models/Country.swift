//
//  Country.swift
//  CountriesList
//
//  Created by Aleem on 08/01/2026.
//

import Foundation

struct Country: Decodable, Identifiable {
    // MARK: - Properties
    let id = UUID()
    let name: String
    let region: String
    let code: String
    let capital: String

    // MARK: - Enum
    private enum CodingKeys: String, CodingKey {
        case name, region, code, capital
    }
}
