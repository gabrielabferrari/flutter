import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Distância até minha casa',
      home: const LocalizacaoPage(),
    );
  }
}

class LocalizacaoPage extends StatefulWidget {
  const LocalizacaoPage({super.key});

  @override
  State<LocalizacaoPage> createState() => _LocalizacaoPageState();
}

class _LocalizacaoPageState extends State<LocalizacaoPage> {
  double? latitude = 0;
  double? longitude = 0;
  double? distancia;
  bool calculouDistancia = false;

  // Coordenadas da sua casa
  final double casaLatitude = -21.483305511565902;
  final double casaLongitude = -47.002914460172676;

  Future<void> _buscarLocalizacao() async {
    bool servicoAtivo = await Geolocator.isLocationServiceEnabled();

    if (!servicoAtivo) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permissao = await Geolocator.checkPermission();

    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
    }

    if (permissao == LocationPermission.denied ||
        permissao == LocationPermission.deniedForever) {
      return;
    }

    Position posicao = await Geolocator.getCurrentPosition();

    double metros = Geolocator.distanceBetween(
      posicao.latitude,
      posicao.longitude,
      casaLatitude,
      casaLongitude,
    );

    setState(() {
      latitude = posicao.latitude;
      longitude = posicao.longitude;
      distancia = metros / 1000;
      calculouDistancia = true;
    });

    print('Latitude: $latitude');
    print('Longitude: $longitude');
    print('Distância: ${distancia?.toStringAsFixed(2)} km');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9E4EA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE9E4EA),
        elevation: 0,
        title: const Text(
          'Distância até minha casa',
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.home,
                size: 100,
                color: Color(0xFF7E57C2),
              ),

              const SizedBox(height: 20),

              const Text(
                'Distância entre a escola e minha casa',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Clique no botão para calcular a distância.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: _buscarLocalizacao,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE8DFF0),
                  foregroundColor: const Color(0xFF7E57C2),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Calcular Distância'),
              ),

              const SizedBox(height: 20),

              if (calculouDistancia)
                Text(
                  '${distancia!.toStringAsFixed(2)} km',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}