//
//  CountryRowView.swift
//  CountriesList
//
//  Created by Aleem on 08/01/2026.
//

import SwiftUI

struct CountryRowView: View {
    
    // MARK: - Properties
    let country: Country
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            HStack {
                Text("\(country.name), \(country.region)")
                    .font(.headline)
                    .lineLimit(1)
                    .truncationMode(.tail)
                Spacer()
                Text(country.code)
                    .font(.headline)
                    .foregroundColor(.gray)
            }
            
            Text(country.capital)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(1)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .background(Color.white)
        .overlay(
            Divider()
                .padding(.leading, 16),
            alignment: .bottom
        )
    }
}
