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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TelaPrincipal(),
    );
  }
}

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  String resultado = 'Clique no botão para calcular';

  // Localização da casa
  // Coloque aqui a latitude e longitude da sua casa
  double latitudeCasa = -21.4678;
  double longitudeCasa = -46.5478;

  Future<void> calcularDistancia() async {
    bool servicoAtivo;
    LocationPermission permissao;

    // Verifica se o GPS está ligado
    servicoAtivo = await Geolocator.isLocationServiceEnabled();

    if (!servicoAtivo) {
      setState(() {
        resultado = 'Ative o GPS do celular.';
      });
      return;
    }

    // Verifica a permissão de localização
    permissao = await Geolocator.checkPermission();

    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();

      if (permissao == LocationPermission.denied) {
        setState(() {
          resultado = 'Permissão de localização negada.';
        });
        return;
      }
    }

    if (permissao == LocationPermission.deniedForever) {
      setState(() {
        resultado = 'Permissão de localização bloqueada.';
      });
      return;
    }

    // Obtém a localização atual
    Position posicaoAtual = await Geolocator.getCurrentPosition();

    // Calcula a distância entre a escola e a casa
    double distancia = Geolocator.distanceBetween(
      posicaoAtual.latitude,
      posicaoAtual.longitude,
      latitudeCasa,
      longitudeCasa,
    );

    // Converte metros para quilômetros
    double distanciaKm = distancia / 1000;

    setState(() {
      resultado =
          'Distância até sua casa:\n${distanciaKm.toStringAsFixed(2)} km';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Distância até minha casa'),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on,
                size: 80,
                color: Colors.red,
              ),

              const SizedBox(height: 20),

              const Text(
                'Escola → Casa',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                resultado,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: calcularDistancia,
                child: const Text(
                  'Calcular distância',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}