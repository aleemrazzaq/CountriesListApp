//
//  ToastView.swift
//  CountriesList
//
//  Created by Aleem on 08/01/2026.
//


import SwiftUI

struct ToastView: View {

    // MARK: - Properties
    let message: String

    // MARK: -  Methods
    var body: some View {
        Text(message)
            .font(.subheadline)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(.black.opacity(0.8))
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.top, 20)
    }
}
