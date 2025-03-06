import 'dart:convert';

import 'package:http/http.dart' as http;

class DogApiService {
  // Holt die Liste aller verfügbaren Hunderassen aus der API
  static Future<List<String>> fetchBreeds() async {
    final response = await http.get(
      Uri.parse('https://dog.ceo/api/breeds/list/all'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<String> breeds = [];

      // Durchläuft alle Hunderassen aus der API-Antwort
      data['message'].forEach((breed, subBreeds) {
        if (subBreeds.isEmpty) {
          // Falls es keine Unterrassen gibt, einfach hinzufügen
          breeds.add(breed);
        } else {
          // Falls es Unterrassen gibt, fügen wir sie mit dem Hauptnamen hinzu
          for (String subBreed in subBreeds) {
            breeds.add('$breed/$subBreed');
          }
        }
      });

      return breeds; // Gibt die Liste aller Rassen zurück
    } else {
      throw Exception(
        'Failed to load dog breeds',
      ); // Falls etwas schiefgeht, Fehler werfen
    }
  }

  // Holt ein Bild einer bestimmten Hunderasse aus der API
  static Future<String> fetchDogImage(String breed) async {
    final response = await http.get(
      Uri.parse('https://dog.ceo/api/breed/$breed/images/random'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['message']; // Gibt die Bild-URL zurück
    } else {
      throw Exception(
        'Failed to load dog image',
      ); // Falls was schiefgeht, Fehler werfen
    }
  }

  // Holt ein komplett zufälliges Hundebild aus der API
  static Future<String> fetchRandomDogImage() async {
    final response = await http.get(
      Uri.parse('https://dog.ceo/api/breeds/image/random'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['message']; // Gibt die Bild-URL zurück
    } else {
      throw Exception(
        'Failed to load random dog image',
      ); // Falls etwas schiefgeht, Fehler werfen
    }
  }
}
