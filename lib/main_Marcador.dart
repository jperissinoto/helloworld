import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meu Mapa',
      home: MapaPage(),
    );
  }
}

class MapaPage extends StatefulWidget {
  const MapaPage({super.key});

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  Position? posicao;
  final MapController _mapController = MapController();

  // Coordenada padrão (Mococa/Região) caso não obtenha a localização ainda
  LatLng localizacaoAtual = const LatLng(-21.470000, -47.030000);

  @override
  void initState() {
    super.initState();
    _obterLocalizacaoAtual();
  }

  // Função para solicitar permissão e pegar a posição do GPS
  Future<void> _obterLocalizacaoAtual() async {
    bool servicoHabilitado;
    LocationPermission permissao;

    servicoHabilitado = await Geolocator.isLocationServiceEnabled();
    if (!servicoHabilitado) {
      return;
    }

    permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
      if (permissao == LocationPermission.denied) {
        return;
      }
    }

    if (permissao == LocationPermission.deniedForever) {
      return;
    }

    Position pos = await Geolocator.getCurrentPosition();
    setState(() {
      posicao = pos;
      localizacaoAtual = LatLng(pos.latitude, pos.longitude);
    });

    // Mover a câmera do mapa para a localização obtida
    _mapController.move(localizacaoAtual, 15);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meu Mapa')),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: localizacaoAtual,
          initialZoom: 13,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.mapa_flutter',
          ),
          // Camada de Marcadores
          MarkerLayer(
            markers: [
              Marker(
                point: localizacaoAtual,
                width: 80,
                height: 80,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _obterLocalizacaoAtual,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}