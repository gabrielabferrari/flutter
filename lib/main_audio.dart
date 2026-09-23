import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(AcademiaApp());
}

class AcademiaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginaAtual = 0;

  // Player do áudio
  final AudioPlayer player = AudioPlayer();

  final exercicios = [
    "Supino Reto",
    "Agachamento",
    "Rosca Direta",
    "Puxada Frontal",
  ];

  // Função para finalizar o exercício
  void finalizarExercicio() async {
    await player.play(
      AssetSource('audio/virtual.mp3'),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Exercício concluído! 💪"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List paginas = [
      inicio(),
      treino(),
      perfil(),
    ];

    return Scaffold(
      body: paginas[paginaAtual],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,

        onTap: (index) {
          setState(() {
            paginaAtual = index;
          });
        },

        backgroundColor: Colors.black,

        selectedItemColor:
            const Color.fromARGB(255, 203, 137, 228),

        unselectedItemColor: Colors.grey,

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Inicio",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: "Treino",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Perfil",
          ),
        ],
      ),
    );
  }

  // ---------------- INICIO ----------------

  Widget inicio() {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        title: Text("Nexora Fitness"),
        backgroundColor:
            const Color.fromARGB(255, 197, 54, 244),
      ),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              "Olá, Priscila",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

            Container(
              padding: EdgeInsets.all(20),
              height: 180,

              decoration: BoxDecoration(
                color: const Color.fromARGB(
                  207,
                  177,
                  124,
                  204,
                ),

                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    "Treino de Hoje",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "Peito + Tríceps",
                    style: TextStyle(fontSize: 30),
                  ),

                  Spacer(),

                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Começar"),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            Text(
              "Meu Progresso",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceAround,

              children: [
                dados("Peso", "78kg"),
                dados("Treinos", "24"),
                dados("Calorias", "5600"),
              ],
            ),

            SizedBox(height: 30),

            Text(
              "Exercícios",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: exercicios.length,

                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.grey[900],

                    child: ListTile(
                      leading: Icon(
                        Icons.fitness_center,
                        color: const Color.fromARGB(
                          255,
                          153,
                          8,
                          244,
                        ),
                      ),

                      title: Text(
                        exercicios[index],
                      ),

                      trailing: ElevatedButton(
                        onPressed: () {
                          finalizarExercicio();
                        },

                        child: Text("Finalizar"),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- TREINO ----------------

  Widget treino() {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        title: Text("Meus Treinos"),
        backgroundColor: Colors.purple,
      ),

      body: ListView(
        padding: EdgeInsets.all(20),

        children: [
          Card(
            color: Colors.grey[900],

            child: ListTile(
              leading: Icon(
                Icons.fitness_center,
                color: Color.fromARGB(255, 116, 13, 168),
              ),

              title: Text("Treino de Peito"),

              subtitle: Text(
                "Supino, Crucifixo e Tríceps",
              ),
            ),
          ),

          SizedBox(height: 30),

          Card(
            color: Colors.grey[900],

            child: ListTile(
              leading: Icon(
                Icons.fitness_center,
                color: const Color.fromARGB(
                  255,
                  116,
                  13,
                  168,
                ),
              ),

              title: Text("Treino de Perna"),

              subtitle: Text(
                "Agachamento, Leg Press e Panturrilha",
              ),
            ),
          ),

          SizedBox(height: 30),

          Card(
            color: Colors.grey[900],

            child: ListTile(
              leading: Icon(
                Icons.fitness_center,
                color: const Color.fromARGB(
                  255,
                  116,
                  13,
                  168,
                ),
              ),

              title: Text("Treino de Costas"),

              subtitle: Text(
                "Puxada, Remada e Bíceps",
              ),
            ),
          ),

          SizedBox(height: 30),

          Card(
            color: Colors.grey[900],

            child: ListTile(
              leading: Icon(
                Icons.fitness_center,
                color: const Color.fromARGB(
                  255,
                  116,
                  13,
                  168,
                ),
              ),

              title: Text("Treino de abdômen"),

              subtitle: Text(
                "Prancha abdominal, abdominal supra e abdominal remador.",
              ),
            ),
          ),

          SizedBox(height: 30),

          Card(
            color: Colors.grey[900],

            child: ListTile(
              leading: Icon(
                Icons.fitness_center,
                color: const Color.fromARGB(
                  255,
                  116,
                  13,
                  168,
                ),
              ),

              title: Text("Treino de ombro"),

              subtitle: Text(
                "Desenvolvimento com halteres ou barra, elevação lateral, elevação frontal, crucifixo inverso e remada alta.",
              ),
            ),
          ),

          SizedBox(height: 30),

          Card(
            color: Colors.grey[900],

            child: ListTile(
              leading: Icon(
                Icons.fitness_center,
                color: const Color.fromARGB(
                  255,
                  116,
                  13,
                  168,
                ),
              ),

              title: Text("Treino de Glúteo"),

              subtitle: Text(
                "Elevação pélvica, agachamento sumô, stiff, afundo e cadeira abdutora.",
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- PERFIL ----------------

  Widget perfil() {
    return Scaffold(
      backgroundColor:
          const Color.fromARGB(42, 22, 9, 32),

      appBar: AppBar(
        title: Text("Meu Perfil"),
        backgroundColor: Colors.purple,
      ),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,

                border: Border.all(
                  color: const Color.fromARGB(
                    255,
                    151,
                    41,
                    214,
                  ),
                  width: 3,
                ),
              ),

              child: CircleAvatar(
                radius: 55,

                backgroundImage:
                    AssetImage(
                  'assets/images/main_imagem.jpg',
                ),
              ),
            ),

            SizedBox(height: 20),

            ListTile(
              leading: Icon(
                Icons.person,
                color: Color.fromARGB(
                  255,
                  116,
                  13,
                  168,
                ),
              ),

              title: Text(
                "Nome: Priscila Silvério",
                style: TextStyle(fontSize: 20),
              ),
            ),

            SizedBox(height: 25),

            ListTile(
              leading: Icon(
                Icons.phone,
                color: Color.fromARGB(
                  255,
                  116,
                  13,
                  168,
                ),
              ),

              title: Text(
                "Telefone: (19) 17865-1578",
                style: TextStyle(fontSize: 20),
              ),
            ),

            SizedBox(height: 25),

            ListTile(
              leading: Icon(
                Icons.login,
                color: Color.fromARGB(
                  255,
                  116,
                  13,
                  168,
                ),
              ),

              title: Text(
                "Login: priscila@email.com",
                style: TextStyle(fontSize: 20),
              ),
            ),

            SizedBox(height: 25),

            ListTile(
              leading: Icon(
                Icons.mail,
                color: Color.fromARGB(
                  255,
                  116,
                  13,
                  168,
                ),
              ),

              title: Text(
                "Email: priscila@email.com",
                style: TextStyle(fontSize: 20),
              ),
            ),

            SizedBox(height: 25),

            ListTile(
              leading: Icon(
                Icons.settings,
                color: Color.fromARGB(
                  255,
                  116,
                  13,
                  168,
                ),
              ),

              title: Text(
                "Configurações",
                style: TextStyle(fontSize: 20),
              ),
            ),

            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  // ---------------- DADOS ----------------

  Widget dados(String titulo, String valor) {
    return Column(
      children: [
        Text(
          valor,

          style: TextStyle(
            color: const Color.fromARGB(
              255,
              110,
              7,
              119,
            ),

            fontSize: 20,

            fontWeight: FontWeight.bold,
          ),
        ),

        Text(titulo),
      ],
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}