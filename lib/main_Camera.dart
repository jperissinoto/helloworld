import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MeuTreinoApp());
}

// ===========================================================
// CORES REUTILIZADAS PELO APP
// ===========================================================
class AppColors {
  static const fundo = Color(0xFF13101A);
  static const cardFundo = Color(0xFF201A2B);
  static const inputFundo = Color(0xFF201A2B);
  static const progressoFundo = Color(0xFF2E2740);
}

// ===========================================================
// MODELO DE EXERCÍCIO
// (antes era Map<String, dynamic>, o que não é seguro:
//  bastava errar o nome de uma chave para quebrar em runtime)
// ===========================================================
class Exercicio {
  final String nome;
  final String detalhe;
  bool feito;

  Exercicio({
    required this.nome,
    required this.detalhe,
    this.feito = false,
  });
}

class MeuTreinoApp extends StatelessWidget {
  const MeuTreinoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PowerFit',
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginaAtual = 0;

  String treinoSelecionado = "Peito e Tríceps";

  // Guarda a foto escolhida (câmera ou galeria)
  File? fotoPerfil;

  final ImagePicker picker = ImagePicker();

  final List<String> treinos = [
    "Peito e Tríceps",
    "Costas e Bíceps",
    "Pernas",
    "Ombros",
    "Treino Completo",
  ];

  late final Map<String, List<Exercicio>> exerciciosPorTreino = {
    "Peito e Tríceps": [
      Exercicio(nome: "Supino Reto", detalhe: "4 séries x 10 repetições"),
      Exercicio(
        nome: "Supino Inclinado com Halteres",
        detalhe: "3 séries x 12 repetições",
      ),
      Exercicio(
        nome: "Crucifixo na Máquina",
        detalhe: "3 séries x 12 repetições",
      ),
      Exercicio(nome: "Tríceps Corda", detalhe: "3 séries x 12 repetições"),
      Exercicio(nome: "Tríceps Testa", detalhe: "3 séries x 10 repetições"),
    ],
    "Costas e Bíceps": [
      Exercicio(nome: "Puxada Frontal", detalhe: "4 séries x 10 repetições"),
      Exercicio(nome: "Remada Curvada", detalhe: "3 séries x 12 repetições"),
      Exercicio(
        nome: "Remada Unilateral",
        detalhe: "3 séries x 10 repetições cada",
      ),
      Exercicio(nome: "Rosca Direta", detalhe: "3 séries x 12 repetições"),
      Exercicio(nome: "Rosca Alternada", detalhe: "3 séries x 10 repetições"),
    ],
    "Pernas": [
      Exercicio(
        nome: "Agachamento Livre",
        detalhe: "4 séries x 10 repetições",
      ),
      Exercicio(nome: "Leg Press", detalhe: "4 séries x 12 repetições"),
      Exercicio(
        nome: "Cadeira Extensora",
        detalhe: "3 séries x 15 repetições",
      ),
      Exercicio(nome: "Mesa Flexora", detalhe: "3 séries x 12 repetições"),
      Exercicio(
        nome: "Panturrilha em Pé",
        detalhe: "4 séries x 15 repetições",
      ),
    ],
    "Ombros": [
      Exercicio(
        nome: "Desenvolvimento com Halteres",
        detalhe: "4 séries x 10 repetições",
      ),
      Exercicio(nome: "Elevação Lateral", detalhe: "3 séries x 15 repetições"),
      Exercicio(nome: "Elevação Frontal", detalhe: "3 séries x 12 repetições"),
      Exercicio(
        nome: "Encolhimento com Barra",
        detalhe: "3 séries x 12 repetições",
      ),
    ],
    "Treino Completo": [
      Exercicio(
        nome: "Agachamento Livre",
        detalhe: "4 séries x 10 repetições",
      ),
      Exercicio(nome: "Supino Reto", detalhe: "3 séries x 10 repetições"),
      Exercicio(nome: "Puxada Frontal", detalhe: "3 séries x 10 repetições"),
      Exercicio(
        nome: "Desenvolvimento com Halteres",
        detalhe: "3 séries x 12 repetições",
      ),
      Exercicio(nome: "Rosca Direta", detalhe: "3 séries x 12 repetições"),
      Exercicio(nome: "Tríceps Corda", detalhe: "3 séries x 12 repetições"),
    ],
  };

  List<Exercicio> get exercicios => exerciciosPorTreino[treinoSelecionado]!;

  // =========================================================
  // ESCOLHER FOTO (câmera ou galeria)
  // =========================================================
  Future<void> escolherFoto(ImageSource origem) async {
    try {
      final XFile? imagem = await picker.pickImage(source: origem);

      if (imagem != null) {
        setState(() {
          fotoPerfil = File(imagem.path);
        });
      }
    } catch (erro) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Não foi possível acessar a câmera/galeria."),
        ),
      );
    }
  }

  void abrirSeletorDeFoto() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cardFundo,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Tirar foto"),
                onTap: () {
                  Navigator.pop(context);
                  escolherFoto(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Escolher da galeria"),
                onTap: () {
                  Navigator.pop(context);
                  escolherFoto(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fundo,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "PowerFit",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: switch (paginaAtual) {
        0 => TelaInicio(exercicios: exercicios),
        1 => TelaTreinos(
            treinos: treinos,
            treinoSelecionado: treinoSelecionado,
            exercicios: exercicios,
            onTreinoAlterado: (valor) {
              setState(() => treinoSelecionado = valor);
            },
            onExercicioAlterado: (index, valor) {
              setState(() => exercicios[index].feito = valor);
            },
            onFinalizarTreino: () {
              setState(() {
                for (final item in exercicios) {
                  item.feito = false;
                }
              });
            },
          ),
        _ => TelaPerfil(
            fotoPerfil: fotoPerfil,
            onTrocarFoto: abrirSeletorDeFoto,
          ),
      },
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        onTap: (index) => setState(() => paginaAtual = index),
        backgroundColor: Colors.black,
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Início"),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: "Treinos",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
      ),
    );
  }
}

// ===========================================================
// TELA INÍCIO
// ===========================================================
class TelaInicio extends StatelessWidget {
  final List<Exercicio> exercicios;

  const TelaInicio({super.key, required this.exercicios});

  @override
  Widget build(BuildContext context) {
    final concluidos = exercicios.where((e) => e.feito).length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [Colors.deepPurple, Colors.purpleAccent],
              ),
            ),
            child: const Column(
              children: [
                Icon(Icons.bolt, size: 60, color: Colors.white),
                SizedBox(height: 10),
                Text(
                  "Bem-vindo ao PowerFit",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Card(
            color: AppColors.cardFundo,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.check_circle,
                color: Colors.greenAccent,
              ),
              title: const Text("Exercícios concluídos"),
              trailing: Text(
                "$concluidos/${exercicios.length}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            color: AppColors.cardFundo,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: const ListTile(
              leading: Icon(Icons.local_fire_department, color: Colors.amber),
              title: Text("Meta semanal"),
              trailing: Text("4 treinos"),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================
// TELA TREINOS
// ===========================================================
class TelaTreinos extends StatelessWidget {
  final List<String> treinos;
  final String treinoSelecionado;
  final List<Exercicio> exercicios;
  final ValueChanged<String> onTreinoAlterado;
  final void Function(int index, bool valor) onExercicioAlterado;
  final VoidCallback onFinalizarTreino;

  const TelaTreinos({
    super.key,
    required this.treinos,
    required this.treinoSelecionado,
    required this.exercicios,
    required this.onTreinoAlterado,
    required this.onExercicioAlterado,
    required this.onFinalizarTreino,
  });

  @override
  Widget build(BuildContext context) {
    final concluidos = exercicios.where((e) => e.feito).length;
    final progresso =
        exercicios.isEmpty ? 0.0 : concluidos / exercicios.length;

    return Column(
      children: [
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: DropdownButtonFormField<String>(
            // Usando "value" (em vez de "initialValue") para manter
            // compatibilidade com versões estáveis mais amplas do Flutter.
            value: treinoSelecionado,
            dropdownColor: AppColors.inputFundo,
            decoration: InputDecoration(
              labelText: "Escolha um treino",
              filled: true,
              fillColor: AppColors.inputFundo,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            items: treinos
                .map(
                  (treino) => DropdownMenuItem<String>(
                    value: treino,
                    child: Text(treino),
                  ),
                )
                .toList(),
            onChanged: (valor) {
              if (valor != null) onTreinoAlterado(valor);
            },
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              LinearProgressIndicator(
                value: progresso,
                minHeight: 10,
                borderRadius: BorderRadius.circular(10),
                color: Colors.deepPurpleAccent,
                backgroundColor: AppColors.progressoFundo,
              ),
              const SizedBox(height: 8),
              Text("$concluidos de ${exercicios.length} concluídos"),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Expanded(
          child: ListView.builder(
            itemCount: exercicios.length,
            itemBuilder: (context, index) {
              final exercicio = exercicios[index];

              return Card(
                color: AppColors.cardFundo,
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 6,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: CheckboxListTile(
                  activeColor: Colors.greenAccent,
                  value: exercicio.feito,
                  title: Text(exercicio.nome),
                  subtitle: Text(exercicio.detalhe),
                  secondary: const CircleAvatar(
                    backgroundColor: Colors.deepPurpleAccent,
                    child: Icon(Icons.fitness_center, color: Colors.white),
                  ),
                  onChanged: (valor) {
                    onExercicioAlterado(index, valor ?? false);
                  },
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                if (exercicios.isNotEmpty && concluidos == exercicios.length) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Parabéns!"),
                        content: const Text("Treino finalizado com sucesso!"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              onFinalizarTreino();
                              Navigator.pop(context);
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Conclua todos os exercícios antes de finalizar.",
                      ),
                    ),
                  );
                }
              },
              child: const Text(
                "FINALIZAR TREINO",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ===========================================================
// TELA PERFIL
// ===========================================================
class TelaPerfil extends StatelessWidget {
  final File? fotoPerfil;
  final VoidCallback onTrocarFoto;

  const TelaPerfil({
    super.key,
    required this.fotoPerfil,
    required this.onTrocarFoto,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          CircleAvatar(
            radius: 55,
            backgroundColor: Colors.deepPurpleAccent,
            backgroundImage: fotoPerfil != null ? FileImage(fotoPerfil!) : null,
            child: fotoPerfil == null
                ? const Icon(Icons.person, size: 60, color: Colors.white)
                : null,
          ),
          const SizedBox(height: 15),
          ElevatedButton.icon(
            onPressed: onTrocarFoto,
            icon: const Icon(Icons.camera_alt),
            label: const Text("Alterar foto"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurpleAccent,
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Usuário",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 25),
          Card(
            color: AppColors.cardFundo,
            child: const ListTile(
              leading: Icon(Icons.monitor_weight),
              title: Text("Peso"),
              trailing: Text("75 kg"),
            ),
          ),
          Card(
            color: AppColors.cardFundo,
            child: const ListTile(
              leading: Icon(Icons.height),
              title: Text("Altura"),
              trailing: Text("1,75 m"),
            ),
          ),
          Card(
            color: AppColors.cardFundo,
            child: const ListTile(
              leading: Icon(Icons.flag),
              title: Text("Meta"),
              trailing: Text("Ganhar Massa"),
            ),
          ),
        ],
      ),
    );
  }
}