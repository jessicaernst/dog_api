import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:dog_api/services/dog_api_services.dart';

import 'dog_api_service_test.mocks.dart';
// auch für Mockito nutzt man dart run build_runner build --delete-conflicting-outputs um Dateien zu generien die wir hier wieder
// importieren müssen damit man die Mocks nutzen kann

@GenerateMocks([http.Client]) // Mockito erstellt einen Mock für http.Client
void main() {
  group('Dog API Tests', () {
    late MockClient mockClient; // Mock-Client für HTTP-Anfragen
    late DogApiService apiService; // Instanz von DogApiService

    setUp(() {
      // Vor jedem Test einen neuen MockClient erstellen
      mockClient = MockClient();
      apiService = DogApiService(
        client: mockClient,
      ); // API-Service mit Mock-Client verbinden
    });

    test('fetchBreeds gibt eine Liste von Hunderassen zurück', () async {
      // Fake API Antwort für die Hunderassenliste
      const fakeResponse = '''
      {
        "message": {
          "affenpinscher": [],
          "bulldog": ["boston", "french"]
        },
        "status": "success"
      }
      ''';

      // Falls die API aufgerufen wird, eine Fake-Antwort zurückgeben
      when(
        mockClient.get(Uri.parse('https://dog.ceo/api/breeds/list/all')),
      ).thenAnswer((_) async => http.Response(fakeResponse, 200));

      // API aufrufen
      final result = await apiService.fetchBreeds();

      // Prüfen, ob die erwarteten Hunderassen enthalten sind
      expect(
        result,
        containsAll(['affenpinscher', 'bulldog/boston', 'bulldog/french']),
      );
    });

    test('fetchDogImage gibt eine gültige Bild-URL zurück', () async {
      // Fake API Antwort für ein Hundebild
      const fakeResponse = '''
      {
        "message": "https://dog.ceo/api/img/bulldog.jpg",
        "status": "success"
      }
      ''';

      // Falls die API für ein Bild einer bestimmten Rasse aufgerufen wird, eine Fake-URL zurückgeben
      when(
        mockClient.get(
          Uri.parse('https://dog.ceo/api/breed/bulldog/images/random'),
        ),
      ).thenAnswer((_) async => http.Response(fakeResponse, 200));

      // API aufrufen
      final result = await apiService.fetchDogImage('bulldog');

      // Prüfen, ob die richtige Bild-URL zurückkommt
      expect(result, equals('https://dog.ceo/api/img/bulldog.jpg'));
    });

    test('fetchRandomDogImage gibt eine zufällige Bild-URL zurück', () async {
      // Fake API Antwort für ein zufälliges Hundebild
      const fakeResponse = '''
      {
        "message": "https://dog.ceo/api/img/random.jpg",
        "status": "success"
      }
      ''';

      // Falls die API für ein zufälliges Bild aufgerufen wird, eine Fake-URL zurückgeben
      when(
        mockClient.get(Uri.parse('https://dog.ceo/api/breeds/image/random')),
      ).thenAnswer((_) async => http.Response(fakeResponse, 200));

      // API aufrufen
      final result = await apiService.fetchRandomDogImage();

      // Prüfen, ob die erwartete Bild-URL zurückkommt
      expect(result, equals('https://dog.ceo/api/img/random.jpg'));
    });

    test(
      'fetchBreeds löst eine Exception aus, wenn die API fehlschlägt',
      () async {
        // Falls die API aufgerufen wird, eine Fehlerantwort (404) zurückgeben
        when(
          mockClient.get(Uri.parse('https://dog.ceo/api/breeds/list/all')),
        ).thenAnswer((_) async => http.Response('Error', 404));

        // Erwartung: Die Funktion sollte eine Exception werfen
        expect(apiService.fetchBreeds(), throwsException);
      },
    );
  });
}
