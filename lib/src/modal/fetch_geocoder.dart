import 'dart:convert';

/// Converts a JSON string into a [FetchGeocoder] object.
FetchGeocoder fetchGeocoderFromJson(String str) =>
    FetchGeocoder.fromJson(json.decode(str));

/// Converts a [FetchGeocoder] object into a JSON string.
String tetchGeocoderToJson(FetchGeocoder data) => json.encode(data.toJson());

/// Represents the response from the Google Maps Geocoding API.
///
/// This class contains the results of a geocoding request, including
/// the list of matching locations and the status of the request.
class FetchGeocoder {
  /// Creates a new instance of [FetchGeocoder].
  ///
  /// [results] The list of geocoding results.
  /// [status] The status of the geocoding request.
  FetchGeocoder({required this.results, required this.status});

  /// The list of geocoding results matching the request.
  List<Result> results;

  /// The status of the geocoding request (e.g., "OK", "ZERO_RESULTS").
  String status;

  /// Creates a [FetchGeocoder] instance from a JSON map.
  factory FetchGeocoder.fromJson(Map<String, dynamic> json) => FetchGeocoder(
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    status: json["status"],
  );

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "status": status,
  };
}

/// Represents a single geocoding result from the Google Maps API.
///
/// Contains detailed information about a location, including its address
/// components, formatted address, geometry, and place ID.
class Result {
  /// Creates a new instance of [Result].
  ///
  /// [addressComponents] The list of address components.
  /// [formattedAddress] The complete formatted address.
  /// [geometry] The geographical information of the location.
  /// [placeId] The unique identifier for the place.
  /// [types] The types of location this result represents.
  Result({
    required this.addressComponents,
    required this.formattedAddress,
    required this.geometry,
    required this.placeId,
    required this.types,
  });

  /// The list of address components that make up this location.
  List<AddressComponent> addressComponents;

  /// The complete formatted address of the location.
  String formattedAddress;

  /// The geographical information of the location.
  Geometry geometry;

  /// The unique identifier for this place in the Google Places database.
  String placeId;

  /// The types of location this result represents (e.g., "street_address", "locality").
  List<String> types;

  /// Creates a [Result] instance from a JSON map.
  factory Result.fromJson(Map<String, dynamic> json) => Result(
    addressComponents: List<AddressComponent>.from(
      json["address_components"].map((x) => AddressComponent.fromJson(x)),
    ),
    formattedAddress: json["formatted_address"],
    geometry: Geometry.fromJson(json["geometry"]),
    placeId: json["place_id"],
    types: List<String>.from(json["types"].map((x) => x)),
  );

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() => {
    "address_components": List<dynamic>.from(
      addressComponents.map((x) => x.toJson()),
    ),
    "formatted_address": formattedAddress,
    "geometry": geometry.toJson(),
    "place_id": placeId,
    "types": List<dynamic>.from(types.map((x) => x)),
  };
}

/// Represents a component of an address (e.g., street number, city, country).
///
/// Each address component has a long name, short name, and types that describe
/// what kind of component it is.
class AddressComponent {
  /// Creates a new instance of [AddressComponent].
  ///
  /// [longName] The full name of the component.
  /// [shortName] The abbreviated name of the component.
  /// [types] The types of this address component.
  AddressComponent({
    required this.longName,
    required this.shortName,
    required this.types,
  });

  /// The full name of the address component.
  String longName;

  /// The abbreviated name of the address component.
  String shortName;

  /// The types of this address component (e.g., "street_number", "route").
  List<String> types;

  /// Creates an [AddressComponent] instance from a JSON map.
  factory AddressComponent.fromJson(Map<String, dynamic> json) =>
      AddressComponent(
        longName: json["long_name"],
        shortName: json["short_name"],
        types: List<String>.from(json["types"].map((x) => x)),
      );

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() => {
    "long_name": longName,
    "short_name": shortName,
    "types": List<dynamic>.from(types.map((x) => x)),
  };
}

/// Represents the geographical information of a location.
///
/// Contains the location coordinates and the type of location (e.g., rooftop,
/// geometric center).
class Geometry {
  /// Creates a new instance of [Geometry].
  ///
  /// [location] The coordinates of the location.
  /// [locationType] The type of location.
  Geometry({required this.location, required this.locationType});

  /// The coordinates of the location.
  Location location;

  /// The type of location (e.g., rooftop, geometric center).
  LocationType locationType;

  /// Creates a [Geometry] instance from a JSON map.
  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
    location: Location.fromJson(json["location"]),
    locationType: locationTypeValues.map[json["location_type"]],
  );

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() => {
    "location": location.toJson(),
    "location_type": locationTypeValues.reverse[locationType],
  };
}

/// Represents a viewport (bounding box) for a location.
///
/// Contains the northeast and southwest corners of the bounding box.
class Viewport {
  /// Creates a new instance of [Viewport].
  ///
  /// [northeast] The northeast corner of the viewport.
  /// [southwest] The southwest corner of the viewport.
  Viewport({required this.northeast, required this.southwest});

  /// The northeast corner of the viewport.
  Location northeast;

  /// The southwest corner of the viewport.
  Location southwest;

  /// Creates a [Viewport] instance from a JSON map.
  factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
    northeast: Location.fromJson(json["northeast"]),
    southwest: Location.fromJson(json["southwest"]),
  );

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() => {
    "northeast": northeast.toJson(),
    "southwest": southwest.toJson(),
  };
}

/// Represents a geographical location with latitude and longitude coordinates.
class Location {
  /// Creates a new instance of [Location].
  ///
  /// [lat] The latitude coordinate.
  /// [lng] The longitude coordinate.
  Location({required this.lat, required this.lng});

  /// The latitude coordinate in decimal degrees.
  double lat;

  /// The longitude coordinate in decimal degrees.
  double lng;

  /// Creates a [Location] instance from a JSON map.
  factory Location.fromJson(Map<String, dynamic> json) =>
      Location(lat: json["lat"].toDouble(), lng: json["lng"].toDouble());

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() => {"lat": lat, "lng": lng};
}

/// The type of location returned by the Google Maps Geocoding API.
enum LocationType {
  /// The location is a rooftop location.
  roofTop,

  /// The location is a geometric center.
  geometricCenter,

  /// The location is an approximate location.
  approximate,

  /// The location is interpolated from a range.
  rangeInterpolated
}

/// Maps between [LocationType] enum values and their string representations.
final locationTypeValues = EnumValues({
  "APPROXIMATE": LocationType.approximate,
  "GEOMETRIC_CENTER": LocationType.geometricCenter,
  "ROOFTOP": LocationType.roofTop,
  "RANGE_INTERPOLATED": LocationType.rangeInterpolated,
});

/// A utility class for mapping between enum values and their string representations.
class EnumValues<T> {
  /// Creates a new instance of [EnumValues].
  ///
  /// [map] The map of string values to enum values.
  EnumValues(map)
    : map = Map.from(map),
      reverseMap = {
        for (var v in map.values) v: map.keys.firstWhere((k) => map[k] == v),
      };

  /// The map of string values to enum values.
  Map<String, T> map;

  /// The map of enum values to string values.
  Map<T, String> reverseMap;

  /// Gets the reverse map of enum values to string values.
  Map<T, String> get reverse {
    return reverseMap;
  }
}
