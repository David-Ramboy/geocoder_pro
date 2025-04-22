# Geocoder Pro

A Flutter package for easy forward and reverse geocoding using the Google Maps API.

## 🚀 Features

- Forward geocoding (address to coordinates)
- Reverse geocoding (coordinates to address)
- Support for multiple languages
- Simple and intuitive API
- Comprehensive address data extraction
- No external dependencies

## 📋 Prerequisites

Before using this package, make sure to:

1. Activate the following APIs in your [Google Cloud Console](https://console.cloud.google.com):
   - Maps SDK for Android
   - Maps SDK for iOS
   - Geocoding API

2. Generate an API key with the necessary permissions

## 📦 Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  geocoder_pro: ^latest_version
```

## 💻 Usage

### Import the package

```dart
import 'package:geocoder_pro/geocoder_pro.dart';
```

### Get Data From Coordinates (Reverse Geocoding)

```dart
GeoData data = await GeocoderPro.getDataFromCoordinates(
    latitude: 40.714224,
    longitude: -73.961452,
    googleMapApiKey: "YOUR_GOOGLE_MAP_API_KEY",
    language: "en" // Optional: specify language code
);

// Access the data
print(data.address);      // Formatted address
print(data.city);         // City name
print(data.country);      // Country name
print(data.countryCode);  // Country code
print(data.latitude);     // Latitude
print(data.longitude);    // Longitude
print(data.postalCode);   // Postal code
print(data.state);        // State/province
print(data.street_number);// Street number
```

### Get Data From Address (Forward Geocoding)

```dart
GeoData data = await GeocoderPro.getDataFromAddress(
    address: "277 Bedford Ave, Brooklyn, NY 11211, USA",
    googleMapApiKey: "YOUR_GOOGLE_MAP_API_KEY",
    language: "en" // Optional: specify language code
);

// Access the data
print(data.address);      // Formatted address
print(data.city);         // City name
print(data.country);      // Country name
print(data.countryCode);  // Country code
print(data.latitude);     // Latitude
print(data.longitude);    // Longitude
print(data.postalCode);   // Postal code
print(data.state);        // State/province
print(data.street_number);// Street number
```

## 🌐 Language Support

You can specify the language parameter to get results in different languages. Check the [Google Maps supported languages](https://developers.google.com/maps/faq#languagesupport) for available language codes.

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## ☕ Support

If you find this package useful, consider supporting the development: