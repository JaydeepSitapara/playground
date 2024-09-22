import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:playground/models/produuct_model2.dart';
import 'package:playground/models/user_model.dart';
import 'package:playground/network/model/post_model.dart';
import 'package:playground/network/model/todos_model.dart';
import 'package:playground/network/model/user_model.dart';

class Repo {
  String url = 'https://jsonplaceholder.typicode.com';
  String postsEndpoint = 'posts';
  String usersEndpoint = 'users';
  String todosEndpoint = 'todos';
  final dio = Dio();
  Future<List<Post>> getPosts() async {
    List<Post> posts = [];
    try {
      Response response = await dio.get('$url/$postsEndpoint');
      List<dynamic> data = response.data;
      posts = data.map((e) => Post.fromJson(e)).toList();
    } catch (e) {
      log(e.toString());
    }
    return posts;
  }

  Future<List<User>> getUsers() async {
    List<User> users = [];
    try {
      Response response = await dio.get('$url/$usersEndpoint');
      List<dynamic> data = response.data;

      users = data.map((e) => User.fromJson(e)).toList();
    } catch (e) {
      log(e.toString());
    }
    return users;
  }

  Future<List<Todo>> getTodos() async {
    List<Todo> todos = [];

    try {
      Response response = await dio.get('$url/$todosEndpoint');
      List<dynamic> todo = response.data;
      todos = todo.map((e) => Todo.fromJson(e)).toList();
    } catch (e) {
      log(e.toString());
    }

    return todos;
  }

  Future<List<User1>> getUsersFromDummy(int limit) async {
    List<User1> usersList = [];

    try {
      final response =
          await dio.get('https://dummyjson.com/users?limit=$limit');

      if (response.statusCode == 200) {
        usersList = User1.listFromJson(response.data['users']);
        log('users list length: ${usersList.length}');
        return usersList;
      }
    } catch (e) {
      log('error in repo : ${e.toString()}');
    }

    return [];
  }

  Future<List<Product>> getProductList(int offset) async {
    List<Product> productList = [];
    try {
      String url =
          "https://api.escuelajs.co/api/v1/products?offset=$offset&limit=10";
      log('Url : ${url}');
      final response = await dio.get(url);
      
      if (response.statusCode == 200) {
        productList = Product.listFromJson(response.data);
        log('product list length: ${productList.length}');
        return productList;
      }
    } catch (e) {
      log('error in repo : ${e.toString()}');
    }

    return [];
  }
}
