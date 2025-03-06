# 🐶 Dog Image Finder

## 📌 Projektbeschreibung
Dieses Flutter-Projekt ist eine **Hundebild-Such-App**, die Bilder von Hunderassen anzeigt. Die App verwendet die **Dog CEO API**, um eine Liste aller Rassen zu laden und zufällige Bilder zu bestimmten oder allen Rassen anzuzeigen. Extrem simpel auf Anfänger Niveau gehalten, sehr bewusst an der Stelle.

## 🎯 Features
- ✅ Liste aller verfügbaren Hunderassen aus der API abrufen.  
- ✅ Bilder von bestimmten Rassen abrufen.  
- ✅ Zufällige Hundebilder anzeigen, wenn "All Breeds" ausgewählt ist.  

## 📂 Projektstruktur
```sh
📁 lib/
 ├── 📁 features/
 │   ├── 📁 dog_selector/        # Feature für die Hundeauswahl
 │   │   ├── 📁 screen/         # Enthält die Haupt-Screen-Datei
 │   │   │   ├── dog_selector_screen.dart
 │   │   ├── 📁 widgets/        # UI-Elemente für das Feature
 │   │   │   ├── dog_image_frame.dart
 ├── 📁 models/                 # Datenmodelle für API-Antworten
 │   ├── dog_breeds.dart
 │   ├── dog_breeds.g.dart
 │   ├── dog_image.dart
 │   ├── dog_image.g.dart
 ├── 📁 services/                # API-Logik für Datenabruf
 │   ├── dog_api_service.dart
 ├── 📁 test/                    # Enthält Unit-Tests für die API
 │   ├── dog_api_service_test.dart
 │   ├── dog_api_service_test.mocks.dart
 ├── main.dart                   # App-Startpunkt
```

## 🔥 API-Integration
Die App nutzt die **Dog CEO API** ([Website](https://dog.ceo/dog-api/)) für den Abruf von Hundebildern und Rassen.

### 🌍 **Verwendete API-Endpunkte**
| Funktion                  | API-URL |
|---------------------------|------------------------------------------|
| Alle Rassen abrufen       | `https://dog.ceo/api/breeds/list/all` |
| Bild einer bestimmten Rasse | `https://dog.ceo/api/breed/{breed}/images/random` |
| Zufälliges Bild abrufen   | `https://dog.ceo/api/breeds/image/random` |

## 🧪 **Unit-Tests**
Die App enthält Unit-Tests für die wichtigsten API-Funktionen. Diese Tests stellen sicher, dass die API korrekt funktioniert und erwartete Werte zurückgibt.

### 📌 **Was wird getestet?**
| Testfall | Beschreibung |
|----------|-------------|
| `fetchBreeds` | Prüft, ob die API eine Liste aller Hunderassen korrekt zurückgibt. |
| `fetchDogImage` | Testet, ob für eine bestimmte Rasse ein Bild zurückkommt. |
| `fetchRandomDogImage` | Überprüft, ob ein zufälliges Hundebild von der API abgerufen wird. |
| `fetchBreeds (Fehlerfall)` | Simuliert eine fehlgeschlagene API-Anfrage (404) und prüft, ob eine Exception geworfen wird. |

### 🚀 **Tests ausführen**
Einmal gewohnt einfach ins File gehen und dort die grünen Ausführpfeile drücken oder aber alternativ über das Terminal:

Um die Tests auszuführen, folgenden Befehl im Terminal verwenden:
```sh
flutter test
```
Falls eine Testdatei spezifisch getestet werden soll:
```sh
flutter test test/dog_api_service_test.dart
```

Falls die Tests fehlschlagen, kann es helfen, die Mocks neu zu generieren:
```sh
dart pub run build_runner build --delete-conflicting-outputs
```

---
### 🚀 **Tipp**
während man die Models erstellt, die auch generiert werden durch json_serializable kann man auch einfach im Terminal
```sh
dart pub run build_runner watch --delete-conflicting-outputs
oder auch 
dart pub run build_runner watch
```
benutzen dann beobachtet der buil_runner die ganze Zeit auf Änderungen und generiert die Files dann gleich etwas angenehmer beim arbeiten
mit control + c beendet man diesen Modus im terminal dann wieder wenn man ihn nicht mehr braucht.
Das geht bei allem wobei man den build_runner ansonsten immer wieder ausführen müsste.