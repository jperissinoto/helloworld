import 'package:flutter/material.dart';

void main() {
  runApp(const MeuTreinoApp());
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

  final List<String> treinos = [
    "Peito e Tríceps",
    "Costas e Bíceps",
    "Pernas",
    "Ombros",
    "Treino Completo"
  ];

  // Agora cada treino tem sua própria lista de exercícios.
  final Map<String, List<Map<String, dynamic>>> exerciciosPorTreino = {
    "Peito e Tríceps": [
      {"nome": "Supino Reto", "detalhe": "4 séries x 10 repetições", "feito": false},
      {"nome": "Supino Inclinado com Halteres", "detalhe": "3 séries x 12 repetições", "feito": false},
      {"nome": "Crucifixo na Máquina", "detalhe": "3 séries x 12 repetições", "feito": false},
      {"nome": "Tríceps Corda", "detalhe": "3 séries x 12 repetições", "feito": false},
      {"nome": "Tríceps Testa", "detalhe": "3 séries x 10 repetições", "feito": false},
    ],
    "Costas e Bíceps": [
      {"nome": "Puxada Frontal", "detalhe": "4 séries x 10 repetições", "feito": false},
      {"nome": "Remada Curvada", "detalhe": "3 séries x 12 repetições", "feito": false},
      {"nome": "Remada Unilateral", "detalhe": "3 séries x 10 repetições cada", "feito": false},
      {"nome": "Rosca Direta", "detalhe": "3 séries x 12 repetições", "feito": false},
      {"nome": "Rosca Alternada", "detalhe": "3 séries x 10 repetições", "feito": false},
    ],
    "Pernas": [
      {"nome": "Agachamento Livre", "detalhe": "4 séries x 10 repetições", "feito": false},
      {"nome": "Leg Press", "detalhe": "4 séries x 12 repetições", "feito": false},
      {"nome": "Cadeira Extensora", "detalhe": "3 séries x 15 repetições", "feito": false},
      {"nome": "Mesa Flexora", "detalhe": "3 séries x 12 repetições", "feito": false},
      {"nome": "Panturrilha em Pé", "detalhe": "4 séries x 15 repetições", "feito": false},
    ],
    "Ombros": [
      {"nome": "Desenvolvimento com Halteres", "detalhe": "4 séries x 10 repetições", "feito": false},
      {"nome": "Elevação Lateral", "detalhe": "3 séries x 15 repetições", "feito": false},
      {"nome": "Elevação Frontal", "detalhe": "3 séries x 12 repetições", "feito": false},
      {"nome": "Encolhimento com Barra", "detalhe": "3 séries x 12 repetições", "feito": false},
    ],
    "Treino Completo": [
      {"nome": "Agachamento Livre", "detalhe": "4 séries x 10 repetições", "feito": false},
      {"nome": "Supino Reto", "detalhe": "3 séries x 10 repetições", "feito": false},
      {"nome": "Puxada Frontal", "detalhe": "3 séries x 10 repetições", "feito": false},
      {"nome": "Desenvolvimento com Halteres", "detalhe": "3 séries x 12 repetições", "feito": false},
      {"nome": "Rosca Direta", "detalhe": "3 séries x 12 repetições", "feito": false},
      {"nome": "Tríceps Corda", "detalhe": "3 séries x 12 repetições", "feito": false},
    ],
  };

  List<Map<String, dynamic>> get exercicios =>
      exerciciosPorTreino[treinoSelecionado]!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF13101A),

      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "PowerFit",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: paginaAtual == 0
          ? telaInicio()
          : paginaAtual == 1
              ? telaTreinos()
              : telaPerfil(),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        onTap: (index) {
          setState(() {
            paginaAtual = index;
          });
        },
        backgroundColor: Colors.black,
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Início",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: "Treinos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Perfil",
          ),
        ],
      ),
    );
  }

  Widget telaInicio() {
    int concluidos =
        exercicios.where((e) => e["feito"] == true).length;

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
                colors: [
                  Colors.deepPurple,
                  Colors.purpleAccent,
                ],
              ),
            ),
            child: const Column(
              children: [
                Icon(
                  Icons.bolt,
                  size: 60,
                ),
                SizedBox(height: 10),
                Text(
                  "Bem-vindo ao PowerFit",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Card(
            color: const Color(0xFF201A2B),
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
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          Card(
            color: const Color(0xFF201A2B),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: const ListTile(
              leading: Icon(
                Icons.local_fire_department,
                color: Colors.amber,
              ),
              title: Text("Meta semanal"),
              trailing: Text("4 treinos"),
            ),
          ),
        ],
      ),
    );
  }

  Widget telaTreinos() {
    int concluidos =
        exercicios.where((e) => e["feito"] == true).length;

    double progresso =
        concluidos / exercicios.length;

    return Column(
      children: [

        const SizedBox(height: 15),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: DropdownButtonFormField<String>(
            value: treinoSelecionado,
            dropdownColor: const Color(0xFF201A2B),
            decoration: InputDecoration(
              labelText: "Escolha um treino",
              filled: true,
              fillColor: const Color(0xFF201A2B),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            items: treinos.map((treino) {
              return DropdownMenuItem(
                value: treino,
                child: Text(treino),
              );
            }).toList(),
            onChanged: (valor) {
              setState(() {
                treinoSelecionado = valor!;
              });
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
                backgroundColor: const Color(0xFF2E2740),
              ),
              const SizedBox(height: 8),
              Text(
                "$concluidos de ${exercicios.length} concluídos",
              ),
            ],
          ),
        ),

        const SizedBox(height: 15),

        Expanded(
          child: ListView.builder(
            itemCount: exercicios.length,
            itemBuilder: (context, index) {
              return Card(
                color: const Color(0xFF201A2B),
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 6,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: CheckboxListTile(
                  activeColor: Colors.greenAccent,
                  value: exercicios[index]["feito"],
                  title: Text(
                    exercicios[index]["nome"],
                  ),
                  subtitle: Text(
                    exercicios[index]["detalhe"],
                  ),
                  secondary: const CircleAvatar(
                    backgroundColor: Colors.deepPurpleAccent,
                    child: Icon(
                      Icons.fitness_center,
                      color: Colors.white,
                    ),
                  ),
                  onChanged: (valor) {
                    setState(() {
                      exercicios[index]["feito"] = valor!;
                    });
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

                if (concluidos == exercicios.length) {

                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Parabéns!"),
                      content: const Text(
                        "Treino finalizado com sucesso!"
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {

                            setState(() {
                              for (var item in exercicios) {
                                item["feito"] = false;
                              }
                            });

                            Navigator.pop(context);
                          },
                          child: const Text("OK"),
                        )
                      ],
                    ),
                  );

                } else {

                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Conclua todos os exercícios antes de finalizar."
                      ),
                    ),
                  );

                }
              },
              child: const Text(
                "FINALIZAR TREINO",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget telaPerfil() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [

          const CircleAvatar(
            radius: 55,
            backgroundColor: Colors.deepPurpleAccent,
            child: Icon(
              Icons.person,
              size: 60,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 15),

          const Text(
            "Usuário",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 25),

          Card(
            color: const Color(0xFF201A2B),
            child: const ListTile(
              leading: Icon(Icons.monitor_weight),
              title: Text("Peso"),
              trailing: Text("75 kg"),
            ),
          ),

          Card(
            color: const Color(0xFF201A2B),
            child: const ListTile(
              leading: Icon(Icons.height),
              title: Text("Altura"),
              trailing: Text("1,75 m"),
            ),
          ),

          Card(
            color: const Color(0xFF201A2B),
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