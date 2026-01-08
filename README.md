

# Countries List App – SwiftUI MVVM 

## Overview

This app fetches and displays a list of countries from a remote JSON endpoint and
shows them in the same order as provided by the API.

Each row displays:
- Country Name and Region
- Country Code (right aligned)
- Capital

## Architecture

The project follows MVVM architecture:

- Model: Country
- Service Layer: CountryService (networking using Combine)
- ViewModel: CountriesViewModel (business logic and UI state)
- View: SwiftUI views observing ViewModel


## Technologies Used

- SwiftUI for UI
- Combine for async data flow
- MVVM design pattern
- Swift Testing for unit tests

## Error Handling and Edge Cases

- HTTP status validation
- JSON decoding validation
- Network failure handling
- Loading state
- Retry support
- Toast notifications for feedback

## Rotation Support

All layouts use adaptive SwiftUI containers (List, VStack, HStack),
so UI automatically supports device rotation and size class changes.

## How to Run

1. Open project in Xcode 16+
2. Select iPhone simulator
3. Run the app

## Tests

Unit tests are written for ViewModel using mocked network service to verify:
- Successful data loading
- Error handling
