import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_list_demo/bloc/post_bloc.dart';
import 'package:infinite_list_demo/ui/post_item.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ScrollController controller = ScrollController();
  PostBloc bloc;

  void onScroll() {
    double maxScroll = controller.position.maxScrollExtent;
    double currentScroll = controller.position.pixels;

    if (currentScroll == maxScroll) {
      bloc.add(PostEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<PostBloc>(context);
    controller.addListener(onScroll);
    return Scaffold(
      appBar: AppBar(
        title: Text("Infinite List with BLoC"),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
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
                  controller: controller,
                  itemCount: (loaded.hasReachedMax)
                      ? loaded.posts.length
                      : loaded.posts.length + 1,
                  itemBuilder: (context, index) => (index < loaded.posts.length)
                      ? PostItem(loaded.posts[index])
                      : (Container(
                          child: Center(
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(),
                          ),
                        ))));
            }
          },
        ),
      ),
    );
  }
}
