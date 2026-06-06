import 'package:flutter/material.dart';
import 'models/tarea.dart';

void main() {
  runApp(const MiApp());
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestor de Tareas',
      home: PantallaPrincipal(),
    );
  }
}

class PantallaPrincipal extends StatefulWidget {
  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  List<Tarea> tareas = [];

  void agregarTarea(String titulo) {
    setState(() {
      tareas.add(Tarea(titulo));
    });
  }

  void eliminarTarea(int index) {
    setState(() {
      tareas.removeAt(index);
    });
  }

  void completarTarea(int index) {
    setState(() {
      tareas[index].completada = !tareas[index].completada;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestor de Tareas"),
      ),
      body: ListView.builder(
        itemCount: tareas.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              tareas[index].titulo,
              style: TextStyle(
                decoration: tareas[index].completada
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            leading: Checkbox(
              value: tareas[index].completada,
              onChanged: (value) {
                completarTarea(index);
              },
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                eliminarTarea(index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final nuevaTarea = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PantallaAgregar(),
            ),
          );

          if (nuevaTarea != null) {
            agregarTarea(nuevaTarea);
          }
        },
      ),
    );
  }
}

class PantallaAgregar extends StatelessWidget {
  final TextEditingController controlador = TextEditingController();

  PantallaAgregar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agregar Tarea"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controlador,
              decoration: const InputDecoration(
                labelText: "Título de la tarea",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Guardar"),
              onPressed: () {
                if (controlador.text.isNotEmpty) {
                  Navigator.pop(
                    context,
                    controlador.text,
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}