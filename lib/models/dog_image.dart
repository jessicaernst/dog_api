import 'package:json_annotation/json_annotation.dart';

part 'dog_image.g.dart';
// mit dem Befehl dart pub run build_runner build wird die Datei dog_breeds.g.dart generiert
// so arbeitet JsonSerializable und dafür benötigt es part 'dog_breeds.g.dart';
// der name vor dem .g.dart muss mit dem Namen der Klasse und des Files übereinstimmen

@JsonSerializable()
class DogImage {
  // Speichert die URL des Hundebildes, das von der API zurückkommt
  final String message;

  // Gibt den Status der API-Antwort an (z. B. "success")
  final String status;

  // Konstruktor mit Pflichtparametern
  DogImage({required this.message, required this.status});

  // Factory-Methode, um JSON-Daten in ein DogImage-Objekt umzuwandeln
  factory DogImage.fromJson(Map<String, dynamic> json) =>
      _$DogImageFromJson(json);

  // Wandelt das DogImage-Objekt zurück in JSON
  Map<String, dynamic> toJson() => _$DogImageToJson(this);
}
