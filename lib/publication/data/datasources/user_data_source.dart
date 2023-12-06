import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/getuser_model.dart';

import 'package:http/http.dart' as http;

import '../models/posh_model.dart';

abstract class UserLocalDataSource {
  Future<List<PostModel>> getUsers(bool conection);
  Future<PostModel> getUser(String id);
  Future<void> createUser(createModel user, bool connection);
  Future<void> updateUser(PostModel user,bool conection);
  Future<void> deleteUser(String id,bool connection);
}

class UserLocalDataSourceImp implements UserLocalDataSource {
  final String _baseUrl = 'http://192.168.1.73:8080';
  @override
  Future<List<PostModel>> getUsers(bool conection) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var response;
    var body;
    bool success = false;
    if (conection) {
      var url = '$_baseUrl/Student/listStudent';
      response = await http.get(Uri.parse(url));

      body = jsonDecode(response.body);
      print(body);

      if (response.statusCode == 200) {
        success = true;
      }
    } else {
      String postsString = sharedPreferences.getString('posts') ?? "[]";
      body = jsonDecode(postsString);
      success = true;
    }
    if (success) {
      List<PostModel> posts =
          body.map<PostModel>((post) => PostModel.fromJson(post)).toList();
      sharedPreferences.setString('posts', jsonEncode(posts));

      return posts;
    } else {
      throw Exception('Failed to load getVideo');
    }
  }

  @override
  Future<PostModel> getUser(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/users/$id'));
    if (response.statusCode == 200) {
      return PostModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

@override
Future<void> createUser(createModel user, bool connection) async {
  if (connection) {
    try {
      await http.post(
        Uri.parse('$_baseUrl/Student'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'title': user.title,
          'post': user.post,
        }),
      );

      // Ahora que los datos se han enviado exitosamente, intenta enviar datos pendientes
      await _sendPendingUsers();
    } catch (e) {
      print('Error during network call: $e');
      throw Exception('Network error');
    }
  } else {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? storedData = prefs.getStringList('pendingUsers');
      if (storedData == null) {
        storedData = [];
      }

      // Convierte el modelo a una representación de cadena (ajusta según tus necesidades)
      String userData = '${user.title},${user.post}';
      storedData.add(userData);

      await prefs.setStringList('pendingUsers', storedData);
      print('Data saved to SharedPreferences');
    } catch (error) {
      print('Error saving data to SharedPreferences: $error');
      // Puedes manejar el error según tus necesidades
    }
  }
}

Future<void> _sendPendingUsers() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedData = prefs.getStringList('pendingUsers');
    if (storedData != null && storedData.isNotEmpty) {
      for (String userData in storedData) {
        List<String> userDataList = userData.split(',');
        createModel user = createModel(
          title: userDataList[0],
          post: userDataList[1],
          // Ajusta según la estructura real de tu modelo
        );

        await http.post(
          Uri.parse('$_baseUrl/Student'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<String, String>{
            'title': user.title,
            'post': user.post,
          }),
        );
      }

      // Borra los datos pendientes después de enviarlos
      await prefs.remove('pendingUsers');
      print('Pending users sent successfully');
    }
  } catch (error) {
    print('Error sending pending users: $error');
    // Puedes manejar el error según tus necesidades
  }
}

@override
Future<void> updateUser(PostModel user, bool connection) async {
  if (connection) {
    try {
      await http.put(
        Uri.parse('$_baseUrl/Student/${user.id}'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'title': user.title,
          'post': user.post,
        }),
      );

      // Ahora que los datos se han actualizado exitosamente, intenta enviar datos pendientes
      await _sendPendingUpdates();
    } catch (e) {
      print('Error during network call: $e');
      throw Exception('Network error');
    }
  } else {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? storedData = prefs.getStringList('pendingUpdates');
      if (storedData == null) {
        storedData = [];
      }

      // Convierte el modelo a una representación de cadena (ajusta según tus necesidades)
      String userData = '${user.id},${user.title},${user.post}';
      storedData.add(userData);

      await prefs.setStringList('pendingUpdates', storedData);
      print('Update data saved to SharedPreferences');
    } catch (error) {
      print('Error saving update data to SharedPreferences: $error');
      // Puedes manejar el error según tus necesidades
    }
  }
}

Future<void> _sendPendingUpdates() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedData = prefs.getStringList('pendingUpdates');
    if (storedData != null && storedData.isNotEmpty) {
      for (String userData in storedData) {
        List<String> userDataList = userData.split(',');
        PostModel user = PostModel(
          id: int.parse(userDataList[0]),
          title: userDataList[1],
          post: userDataList[2],
          // Ajusta según la estructura real de tu modelo
        );

        await http.put(
          Uri.parse('$_baseUrl/Student/${user.id}'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<String, String>{
            'title': user.title,
            'post': user.post,
          }),
        );
      }

      // Borra los datos pendientes después de enviarlos
      await prefs.remove('pendingUpdates');
      print('Pending updates sent successfully');
    }
  } catch (error) {
    print('Error sending pending updates: $error');
    // Puedes manejar el error según tus necesidades
  }
}


 @override
Future<void> deleteUser(String id, bool connection) async {
  if (connection) {
    try {
      final http.Response response = await http.delete(
        Uri.parse('$_baseUrl/Student/$id'),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete user');
      }

      // Ahora que el usuario se ha eliminado exitosamente, intenta enviar operaciones pendientes
      await _sendPendingDeletions();
    } catch (e) {
      print('Error during network call: $e');
      throw Exception('Network error');
    }
  } else {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? storedData = prefs.getStringList('pendingDeletions');
      if (storedData == null) {
        storedData = [];
      }

      // Almacena la operación de eliminación pendiente
      storedData.add(id);

      await prefs.setStringList('pendingDeletions', storedData);
      print('Delete operation saved to SharedPreferences');
    } catch (error) {
      print('Error saving delete operation to SharedPreferences: $error');
      // Puedes manejar el error según tus necesidades
    }
  }
}

Future<void> _sendPendingDeletions() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedData = prefs.getStringList('pendingDeletions');
    if (storedData != null && storedData.isNotEmpty) {
      for (String id in storedData) {
        await http.delete(
          Uri.parse('$_baseUrl/Student/$id'),
        );
      }

      // Borra las operaciones pendientes después de enviarlas
      await prefs.remove('pendingDeletions');
      print('Pending deletions sent successfully');
    }
  } catch (error) {
    print('Error sending pending deletions: $error');
    // Puedes manejar el error según tus necesidades
  }
}

}
