import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/publication/presentations/pages/putpost_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/getpost/getpost_bloc.dart';
import '../bloc/getpost/getpost_event.dart';
import '../bloc/getpost/getpost_state.dart';
import '../bloc/delitepost/delitepost_bloc.dart';
import '../bloc/delitepost/delitepost_event.dart';
import 'createpost_page.dart';
class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => GetPostPage();
}
class GetPostPage extends State<PostsPage> {
  late StreamSubscription<ConnectivityResult> subscription;
  @override
  void initState() {
    super.initState();
 context.read<GetPostBloc>().add(FetchPostsEvent());
 
 late StreamSubscription<ConnectivityResult> subscription;
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Se perdió la conectividad Wi-Fi', style: TextStyle()),
            duration: Duration(seconds: 3),
          ),
        );
      }
    });
  }
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Posts')),

      body: BlocBuilder<GetPostBloc, GetPostState>(
        builder: (context, state) {
          if (state is PostsInitial) {
           // BlocProvider.of<GetPostBloc>(context).add(FetchPostsEvent(conection: true));
            return Center(child: CircularProgressIndicator());
          } else if (state is PostsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PostsLoaded) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.posts[index].title),
                  subtitle: Text(state.posts[index].post),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdatePostPage(post: state.posts[index]),
                            ),
                          );
                        },
                        child: Text('Actualizar'),
                      ),
                      SizedBox(width: 8.0),
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<DelitePostBloc>(context).add(DeleteUserEvent(state.posts[index].id.toString()));

                         // BlocProvider.of<GetPostBloc>(context).add(FetchPostsEvent(conection: true));
                        },
                        child: Text('Eliminar'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                        ),
                      ),

                    ],
                  ),
                );
              },
            );
          } else if (state is PostsLoadFailure) {
            return Center(child: Text(state.error));
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePostPage()),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Crear Nuevo Post',
      ),
    );

  }
}
