import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_list_demo/bloc/post_bloc.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Infinite List with BLoC"),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostUninitialized) {
              return Center(
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              PostLoaded loaded = state as PostLoaded;
              return ListView.builder(
                  itemCount: loaded.posts.length,
                  itemBuilder: (context, index) =>
                      Text(loaded.posts[index].title));
            }
          },
        ),
      ),
    );
  }
}
