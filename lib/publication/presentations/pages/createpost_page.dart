import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/posh_model.dart';
import '../../domain/entities/Postcreate.dart';
import '../bloc/createpost/createpost_bloc.dart';
import '../bloc/createpost/createpost_event.dart';
import '../bloc/createpost/createpost_state.dart';
import '../bloc/getpost/getpost_bloc.dart';
import '../bloc/getpost/getpost_event.dart';
import 'getPost_page.dart';


class CreatePostPage extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Post'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            BlocProvider.of<GetPostBloc>(context).add(FetchPostsEvent()); // Agregar este evento
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => PostsPage()),
            );
          },
        ),
      ),

      body: BlocConsumer<CreatePostBloc, CreatePostState>(
        listener: (context, state) {
          if (state is UserCreatedSuccessfully) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Post creado exitosamente!')),
            );
            titleController.clear();
            postController.clear();
          } else if (state is UserCreationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.error}')),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Título'),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: postController,
                  decoration: InputDecoration(labelText: 'Post'),
                ),
                SizedBox(height: 16),
                state is UserLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: () {
                    final post = createModel(
                      title: titleController.text,
                      post: postController.text,
                    );
                    context.read<CreatePostBloc>().add(
                      CreateUserEvent(post),
                    );
                  },
                  child: Text('Crear Post'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
