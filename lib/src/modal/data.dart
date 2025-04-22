/// A data model class representing geographical location information.
///
/// This class contains all the relevant information about a location,
/// including its coordinates, address components, and administrative details.
class GeoData {
  /// Creates a new instance of [GeoData] with the specified location details.
  ///
  /// [address] The complete formatted address of the location.
  /// [city] The city or locality name.
  /// [country] The country name.
  /// [latitude] The latitude coordinate of the location.
  /// [longitude] The longitude coordinate of the location.
  /// [postalCode] The postal or ZIP code of the location.
  /// [state] The state or province name.
  /// [countryCode] The two-letter country code (ISO 3166-1 alpha-2).
  /// [streetNumber] The street number of the location.
  GeoData({
    required this.address,
    required this.city,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.postalCode,
    required this.state,
    required this.countryCode,
    required this.streetNumber,
  });

  /// The complete formatted address of the location.
  String address;

  /// The city or locality name where the location is situated.
  String city;

  /// The country name where the location is situated.
  String country;

  /// The latitude coordinate of the location in decimal degrees.
  double latitude;

  /// The longitude coordinate of the location in decimal degrees.
  double longitude;

  /// The postal or ZIP code of the location.
  String postalCode;

  /// The state or province name where the location is situated.
  String state;

  /// The two-letter country code (ISO 3166-1 alpha-2) of the location.
  String countryCode;

  /// The street number of the location.
  String streetNumber;
}
