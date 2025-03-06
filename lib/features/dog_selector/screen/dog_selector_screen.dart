import 'package:dog_api/features/dog_selector/widgets/dog_image_frame.dart';
import 'package:dog_api/services/dog_api_services.dart';
import 'package:flutter/material.dart';

class DogSelectorScreen extends StatefulWidget {
  const DogSelectorScreen({super.key});

  @override
  State<DogSelectorScreen> createState() => _DogSelectorScreenState();
}

class _DogSelectorScreenState extends State<DogSelectorScreen> {
  // Standardmäßig ist "All" ausgewählt, damit zufällige Bilder geladen werden
  String selectedBreed = 'all';
  List<String> breeds = ['all']; // Liste aller Hunderassen, beginnt mit "All"
  String imageUrl = ''; // Hier wird das Bild gespeichert
  bool isLoading = false; // Zeigt an, ob ein Bild gerade geladen wird

  @override
  void initState() {
    super.initState();
    loadBreeds(); // Beim Start die Rassen und ein Bild laden
  }

  // Holt die Liste aller verfügbaren Hunderassen aus der API
  Future<void> loadBreeds() async {
    try {
      final List<String> fetchedBreeds = await DogApiService.fetchBreeds();
      setState(() {
        breeds.addAll(fetchedBreeds);
      });
      loadDogImage(); // Nachdem die Rassen geladen sind, direkt ein Bild holen
    } catch (e) {
      debugPrint('Error loading breeds: $e');
    }
  }

  // Lädt ein Hundebild – entweder zufällig oder nach ausgewählter Rasse
  Future<void> loadDogImage() async {
    setState(() {
      isLoading =
          true; // Setzt den Ladezustand auf "true", damit der Loader angezeigt wird
    });
    try {
      String fetchedImage;
      if (selectedBreed == 'all') {
        // Wenn "All" gewählt ist, wird ein zufälliges Bild aus allen Rassen geladen
        fetchedImage = await DogApiService.fetchRandomDogImage();
      } else {
        // Falls eine spezifische Rasse gewählt wurde, wird ein Bild dieser Rasse geladen
        fetchedImage = await DogApiService.fetchDogImage(selectedBreed);
      }
      setState(() {
        imageUrl = fetchedImage; // Speichert das geladene Bild in der Variable
      });
    } catch (e) {
      debugPrint('Error loading image: $e');
    }
    setState(() {
      isLoading = false; // Nach dem Laden wieder auf "false" setzen
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dog Image Finder')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              // Dropdown-Menü zur Auswahl der Rasse
              DropdownButton<String>(
                value: selectedBreed,
                items:
                    breeds.map((breed) {
                      return DropdownMenuItem(
                        value: breed,
                        child: Text(
                          breed == 'all'
                              ? 'ALL BREEDS' // Falls "All" gewählt ist, wird das so angezeigt
                              : breed
                                  .replaceAll('/', ' ')
                                  .toUpperCase(), // Entfernt "/" aus Rassennamen
                        ),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedBreed = value ?? 'all'; // Setzt die Auswahl um
                  });
                  loadDogImage(); // Nach Auswahl sofort neues Bild laden
                },
              ),
              const SizedBox(height: 16),
              // Button, um ein neues Bild zu laden
              ElevatedButton(
                onPressed: loadDogImage,
                child: const Text('Fetch Dog Image'),
              ),
              const Spacer(),
              // Zeigt entweder einen Lade-Indikator oder das Bild an
              isLoading
                  ? const CircularProgressIndicator()
                  : imageUrl.isNotEmpty
                  ? DogImageFrame(imageUrl: imageUrl)
                  : const Text('No image loaded'),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
