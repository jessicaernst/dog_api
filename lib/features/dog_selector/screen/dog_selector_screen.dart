import 'package:dog_api/services/dog_api_services.dart';
import 'package:flutter/material.dart';
import 'package:dog_api/features/dog_selector/widgets/dog_image_frame.dart';

class DogSelectorScreen extends StatefulWidget {
  const DogSelectorScreen({super.key});

  @override
  State<DogSelectorScreen> createState() => _DogSelectorScreenState();
}

class _DogSelectorScreenState extends State<DogSelectorScreen> {
  final DogApiService apiService = DogApiService(); // Instanz von DogApiService
  String selectedBreed = 'all'; // Standardmäßig "All" für zufällige Bilder
  List<String> breeds = ['all']; // Liste mit allen Rassen, beginnt mit "All"
  String imageUrl = ''; // Speichert das Bild
  bool isLoading = false; // Wird genutzt, um Ladeindikator anzuzeigen
  String? errorMessage; // Fehlermeldungen

  @override
  void initState() {
    super.initState();
    loadBreeds(); // Holt beim Start die Rassen + direkt ein Bild
  }

  // 📌 Holt die Liste aller Hunderassen
  Future<void> loadBreeds() async {
    setState(() {
      isLoading = true;
      errorMessage = null; // Falls vorher ein Fehler da war, zurücksetzen
    });

    try {
      final List<String> fetchedBreeds = await apiService.fetchBreeds();
      setState(() {
        breeds.addAll(fetchedBreeds);
      });
      loadDogImage(); // Direkt ein Bild laden
    } catch (e) {
      setState(() {
        errorMessage = "Fehler beim Laden der Rassen!"; // Fehler anzeigen
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  // 📌 Lädt das Hundebild (Zufällig oder nach Auswahl)
  Future<void> loadDogImage() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      String fetchedImage;
      if (selectedBreed == 'all') {
        fetchedImage = await apiService.fetchRandomDogImage();
      } else {
        fetchedImage = await apiService.fetchDogImage(selectedBreed);
      }
      setState(() {
        imageUrl = fetchedImage;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Fehler beim Laden des Bildes!";
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🐶 Dog Image Finder')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              // 📌 Dropdown-Menü für die Hunderassenauswahl
              DropdownButton<String>(
                value: selectedBreed,
                items:
                    breeds.isNotEmpty
                        ? breeds.map((breed) {
                          return DropdownMenuItem(
                            value: breed,
                            child: Text(
                              breed == 'all'
                                  ? 'ALL BREEDS'
                                  : breed.replaceAll('/', ' ').toUpperCase(),
                            ),
                          );
                        }).toList()
                        : [],
                onChanged: (value) {
                  setState(() {
                    selectedBreed = value ?? 'all';
                  });
                  loadDogImage(); // Direkt neues Bild laden
                },
              ),
              const SizedBox(height: 16),

              // 📌 Button zum Neuladen
              ElevatedButton(
                onPressed: loadDogImage,
                child: const Text('Fetch Dog Image'),
              ),

              const Spacer(),

              // 📌 Ladeanimation, Fehler oder Bild anzeigen
              if (isLoading)
                const CircularProgressIndicator()
              else if (errorMessage != null)
                Text(errorMessage!, style: const TextStyle(color: Colors.red))
              else if (imageUrl.isNotEmpty)
                DogImageFrame(imageUrl: imageUrl)
              else
                const Text('No image loaded'),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
