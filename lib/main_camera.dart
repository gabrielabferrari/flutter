import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MinhasTarefasApp());
}

class MinhasTarefasApp extends StatelessWidget {
  const MinhasTarefasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Minhas Tarefas',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color.fromARGB(255, 199, 79, 255),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      home: const HomePage(),
    );
  }
}

class Task {
  String titulo;
  String horario;
  bool concluida;

  Task({
    required this.titulo,
    required this.horario,
    this.concluida = false,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginaAtual = 0;
  int categoriaAtual = 0;

  File? foto;

  final List<Task> tarefas = [
    Task(titulo: "Estudar Flutter", horario: "10:00"),
    Task(titulo: "Reunião com equipe", horario: "14:00"),
    Task(titulo: "Enviar relatório", horario: "16:30"),
    Task(titulo: "Fazer compras", horario: "09:00"),
    Task(titulo: "Ler livro", horario: "20:00"),
  ];

  Future<void> tirarFoto() async {
    final picker = ImagePicker();

    final imagem = await picker.pickImage(source: ImageSource.camera);

    if (imagem != null) {
      setState(() {
        foto = File(imagem.path);
        paginaAtual = 3;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 180, 33, 253),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Minhas Tarefas"),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_a_photo),
            onPressed: tirarFoto,
          ),
        ],
      ),
      body: IndexedStack(
        index: paginaAtual,
        children: [
          telaTarefas(),
          telaCalendario(),
          telaPrioridades(),
          telaPerfil(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        selectedItemColor: const Color.fromARGB(255, 173, 42, 255),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            paginaAtual = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Tarefas",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Calendário",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Prioridades",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Perfil",
          ),
        ],
      ),
    );
  }

  Widget telaTarefas() {
    return Column(
      children: [
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            categoriaBotao("Todas", 0),
            categoriaBotao("Pendentes", 1),
            categoriaBotao("Concluídas", 2),
          ],
        ),
        const SizedBox(height: 15),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            itemCount: tarefas.length,
            itemBuilder: (context, index) {
              Task tarefa = tarefas[index];

              if (categoriaAtual == 1 && tarefa.concluida) {
                return const SizedBox();
              }

              if (categoriaAtual == 2 && !tarefa.concluida) {
                return const SizedBox();
              }

              return Card(
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  leading: Checkbox(
                    value: tarefa.concluida,
                    activeColor: const Color.fromARGB(255, 120, 48, 255),
                    onChanged: (value) {
                      setState(() {
                        tarefa.concluida = value!;
                      });
                    },
                  ),
                  title: Text(
                    tarefa.titulo,
                    style: TextStyle(
                      decoration: tarefa.concluida
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(tarefa.horario),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget categoriaBotao(String texto, int indice) {
    bool selecionado = categoriaAtual == indice;

    return GestureDetector(
      onTap: () {
        setState(() {
          categoriaAtual = indice;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: selecionado
              ? const Color.fromARGB(255, 159, 42, 255)
              : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          texto,
          style: TextStyle(
            color: selecionado ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget telaCalendario() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Icon(
            Icons.calendar_month,
            size: 90,
            color: Color.fromARGB(255, 164, 99, 255),
          ),
          const SizedBox(height: 20),
          const Text(
            "Calendário",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "Agosto 2026",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(height: 20),
                  Icon(
                    Icons.calendar_today,
                    size: 70,
                    color: Color.fromARGB(255, 177, 99, 255),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Nenhum evento para hoje.",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget telaPrioridades() {
    List<Task> pendentes =
        tarefas.where((t) => !t.concluida).toList();

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          "Prioridades",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        ...pendentes.map((tarefa) {
          return Card(
            child: ListTile(
              leading: const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              title: Text(tarefa.titulo),
              subtitle: Text(tarefa.horario),
            ),
          );
        }),
      ],
    );
  }

  Widget telaPerfil() {
    int concluidas =
        tarefas.where((t) => t.concluida).length;

    int pendentes =
        tarefas.where((t) => !t.concluida).length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 20),

          const CircleAvatar(
            radius: 55,
            backgroundColor: Color.fromARGB(255, 164, 99, 255),
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 60,
            ),
          ),

          const SizedBox(height: 20),

          if (foto != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.file(
                foto!,
                width: 220,
                height: 220,
                fit: BoxFit.cover,
              ),
            )
          else
            const Text(
              "Nenhuma foto capturada",
              style: TextStyle(color: Colors.grey),
            ),

          const SizedBox(height: 20),

          const Text(
            "Gabriela",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Text(
            "gabriela@email.com",
            style: TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 30),

          Card(
            child: ListTile(
              leading: const Icon(Icons.list),
              title: const Text("Total de tarefas"),
              trailing: Text("${tarefas.length}"),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.pending_actions),
              title: const Text("Pendentes"),
              trailing: Text("$pendentes"),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.check_circle),
              title: const Text("Concluídas"),
              trailing: Text("$concluidas"),
            ),
          ),
        ],
      ),
    );
  }
}