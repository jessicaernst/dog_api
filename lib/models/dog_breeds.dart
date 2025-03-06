import 'package:json_annotation/json_annotation.dart';

part 'dog_breeds.g.dart';
// mit dem Befehl dart pub run build_runner build wird die Datei dog_breeds.g.dart generiert
// so arbeitet JsonSerializable und dafür benötigt es part 'dog_breeds.g.dart';
// der name vor dem .g.dart muss mit dem Namen der Klasse und des Files übereinstimmen

@JsonSerializable()
class DogBreeds {
  // Speichert alle Hunderassen aus der API als Map
  // Der Schlüssel ist der Rassenname, die Werte sind mögliche Unterrassen
  final Map<String, List<String>> message;

  // Gibt den Status der API-Antwort an (z. B. "success")
  final String status;

  // Konstruktor mit Pflichtparametern
  DogBreeds({required this.message, required this.status});

  // Factory-Methode, um JSON-Daten in ein DogBreeds-Objekt umzuwandeln
  factory DogBreeds.fromJson(Map<String, dynamic> json) =>
      _$DogBreedsFromJson(json);

  // Wandelt das DogBreeds-Objekt zurück in JSON
  Map<String, dynamic> toJson() => _$DogBreedsToJson(this);
}
