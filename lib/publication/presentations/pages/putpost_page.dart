import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/getuser_model.dart';
import '../bloc/getpost/getpost_bloc.dart';
import '../bloc/getpost/getpost_event.dart';
import '../bloc/putpost/putpost_bloc.dart'; // Importa el BLoC de actualización y eventos relacionados
import '../bloc/putpost/putpost_event.dart';
import 'getPost_page.dart';

class UpdatePostPage extends StatefulWidget {
  final PostModel post;

  UpdatePostPage({required this.post});

  @override
  _UpdatePostPageState createState() => _UpdatePostPageState();
}

class _UpdatePostPageState extends State<UpdatePostPage> {
  late TextEditingController _titleController;
  late TextEditingController _postController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.post.title);
    _postController = TextEditingController(text: widget.post.post);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actualizar Post'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            BlocProvider.of<GetPostBloc>(context).add(FetchPostsEvent());
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => PostsPage()),
            );
          },
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _postController,
              decoration: InputDecoration(labelText: 'Contenido'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Usar el BLoC para disparar un evento de actualización
                final updatedPost = PostModel(
                  id: widget.post.id,
                  title: _titleController.text,
                  post: _postController.text,
                );
                BlocProvider.of<PutPostBloc>(context).add(UpdateUserEvent(updatedPost));

              },
              child: Text('Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }
}
