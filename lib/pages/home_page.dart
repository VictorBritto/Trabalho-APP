import 'package:flutter/material.dart';
import 'package:trabalho/components/my_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  String? _editPostId; // ID da postagem que está sendo editada
  bool _showPostInput = false; // Controle da visibilidade da caixa de postagem

  void _enviarPostagem() async {
    if (_controller.text.isNotEmpty) {
      if (_editPostId == null) {
        // Criar nova postagem
        await FirebaseFirestore.instance.collection('postagens').add({
          'texto': _controller.text,
          'data': Timestamp.now(),
          'curtidas': 0, // Inicializa o contador de curtidas
        });
      } else {
        // Editar postagem existente
        await FirebaseFirestore.instance.collection('postagens').doc(_editPostId).update({
          'texto': _controller.text,
        });
        _editPostId = null; // Limpar o ID após a edição
      }
      _controller.clear();
      setState(() {
        _showPostInput = false; // Esconder a caixa após enviar
      });
    }
  }

  void _editarPostagem(String id, String texto) {
    _editPostId = id;
    _controller.text = texto;
    setState(() {
      _showPostInput = true; // Mostrar a caixa de postagem ao editar
    });
  }

  void _deletarPostagem(String id) async {
    await FirebaseFirestore.instance.collection('postagens').doc(id).delete();
  }

  void _curtirPostagem(String id, int curtidas) async {
    await FirebaseFirestore.instance.collection('postagens').doc(id).update({
      'curtidas': curtidas + 1, // Incrementa o contador de curtidas
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: MyDrawer(),
      appBar: AppBar(
        title: const Text("I N I C I O"),
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_showPostInput) ...[
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'O que está acontecendo?',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _enviarPostagem,
                child: const Text('Postar'),
              ),
              const SizedBox(height: 16), // Espaço entre o input e a lista
            ],
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _showPostInput = !_showPostInput; // Alternar visibilidade
                });
              },
              child: Text(_showPostInput ? 'Cancelar' : 'Nova Postagem'),
            ),
            const SizedBox(height: 16), // Espaço entre o botão e a lista
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('postagens').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView(
                    children: snapshot.data!.docs.map((doc) {
                      return ListTile(
                        title: Text(doc['texto']),
                        
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.thumb_up),
                              onPressed: () => _curtirPostagem(doc.id, doc['curtidas']),
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _editarPostagem(doc.id, doc['texto']),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _deletarPostagem(doc.id),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
