# 🐶 Dog Image Finder

## 📌 Projektbeschreibung
Dieses Flutter-Projekt ist eine **Hundebild-Such-App**, die Bilder von Hunderassen anzeigt. Die App verwendet die **Dog CEO API**, um eine Liste aller Rassen zu laden und zufällige Bilder zu bestimmten oder allen Rassen anzuzeigen. Extrem simpel auf Anfänger Niveau gehalten, sehr bewusst an der Stelle

## 🎯 Features
- ✅ Liste aller verfügbaren Hunderassen aus der API abrufen.  
- ✅ Bilder von bestimmten Rassen abrufen.  
- ✅ Zufällige Hundebilder anzeigen, wenn "All Breeds" ausgewählt ist.  
- ✅ Elegantes **Dark-Theme** mit einer modernen Benutzeroberfläche.  

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



