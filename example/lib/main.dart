import 'package:flutter/material.dart';
import 'package:geocoder_pro/geocoder_pro.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geocoder Pro Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GeocoderExample(),
    );
  }
}

class GeocoderExample extends StatefulWidget {
  const GeocoderExample({super.key});

  @override
  State<GeocoderExample> createState() => _GeocoderExampleState();
}

class _GeocoderExampleState extends State<GeocoderExample> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _apiKeyController = TextEditingController();
  
  String _result = '';
  bool _isLoading = false;

  @override
  void dispose() {
    _addressController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    _apiKeyController.dispose();
    super.dispose();
  }

  Future<void> _geocodeAddress() async {
    if (_addressController.text.isEmpty || _apiKeyController.text.isEmpty) {
      setState(() {
        _result = 'Please enter an address and API key';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _result = '';
    });

    try {
      final geoData = await GeocoderPro.getDataFromAddress(
        address: _addressController.text,
        googleMapApiKey: _apiKeyController.text,
      );

      setState(() {
        _result = geoData != null
            ? 'Address: ${geoData.address}\n'
                'City: ${geoData.city}\n'
                'State: ${geoData.state}\n'
                'Country: ${geoData.country}\n'
                'Postal Code: ${geoData.postalCode}\n'
                'Coordinates: ${geoData.latitude}, ${geoData.longitude}'
            : 'No results found';
      });
    } catch (e) {
      setState(() {
        _result = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _reverseGeocode() async {
    if (_latitudeController.text.isEmpty ||
        _longitudeController.text.isEmpty ||
        _apiKeyController.text.isEmpty) {
      setState(() {
        _result = 'Please enter coordinates and API key';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _result = '';
    });

    try {
      final geoData = await GeocoderPro.getDataFromCoordinates(
        latitude: double.parse(_latitudeController.text),
        longitude: double.parse(_longitudeController.text),
        googleMapApiKey: _apiKeyController.text,
      );

      setState(() {
        _result = geoData != null
            ? 'Address: ${geoData.address}\n'
                'City: ${geoData.city}\n'
                'State: ${geoData.state}\n'
                'Country: ${geoData.country}\n'
                'Postal Code: ${geoData.postalCode}'
            : 'No results found';
      });
    } catch (e) {
      setState(() {
        _result = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geocoder Pro Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _apiKeyController,
                decoration: const InputDecoration(
                  labelText: 'Google Maps API Key',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              const Text(
                'Forward Geocoding (Address to Coordinates)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Enter Address',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _isLoading ? null : _geocodeAddress,
                child: Text(_isLoading ? 'Loading...' : 'Geocode Address'),
              ),
              const SizedBox(height: 24),
              const Text(
                'Reverse Geocoding (Coordinates to Address)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _latitudeController,
                      decoration: const InputDecoration(
                        labelText: 'Latitude',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _longitudeController,
                      decoration: const InputDecoration(
                        labelText: 'Longitude',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _isLoading ? null : _reverseGeocode,
                child: Text(_isLoading ? 'Loading...' : 'Reverse Geocode'),
              ),
              const SizedBox(height: 24),
              if (_result.isNotEmpty) ...[
                const Text(
                  'Results:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(_result),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
} 