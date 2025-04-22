# Geocoder Pro Example

This example demonstrates how to use the `geocoder_pro` package to perform both forward and reverse geocoding operations.

## Features

- Forward Geocoding: Convert an address to coordinates (latitude and longitude)
- Reverse Geocoding: Convert coordinates to a physical address
- Material Design 3 UI
- Error handling
- Loading states

## Getting Started

1. Make sure you have Flutter installed and set up
2. Get a Google Maps API key from the [Google Cloud Console](https://console.cloud.google.com/)
3. Enable the Geocoding API for your project
4. Clone this repository
5. Navigate to the example directory
6. Run `flutter pub get` to install dependencies
7. Run `flutter run` to start the example

## Usage

1. Enter your Google Maps API key in the first text field
2. For forward geocoding:
   - Enter an address (e.g., "1600 Amphitheatre Parkway, Mountain View, CA")
   - Click "Geocode Address"
3. For reverse geocoding:
   - Enter latitude and longitude coordinates
   - Click "Reverse Geocode"

## Note

Make sure to keep your API key secure and never commit it to version control. In a production app, you should store it securely using environment variables or a secure storage solution. 