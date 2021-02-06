import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:futcrick/Extension.dart';
import 'package:futcrick/datamodel/Post.dart';
import 'package:futcrick/datamodel/PostItem.dart';
import 'package:futcrick/main.dart';
import 'package:futcrick/pages/NewPost.dart';

import '../Constants.dart';

class MyHomePage extends StatefulWidget {
  final User user;

  const MyHomePage({Key key, this.user}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with AutomaticKeepAliveClientMixin<MyHomePage> {
  List<PostItem> postItems = [];
  List<DocumentSnapshot> documents = [];
  ScrollController _scrollController;
  bool isMore = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(scrollListener);
    fetchPosts(widget.user);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  scrollListener() {
    if (_scrollController.hasClients) {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        fetchPosts(widget.user);
      }
    }
  }

  Future<void> fetchPosts(User user) async {
    if (isMore) {
      QuerySnapshot snapshot;
      if (postItems.length == 0) {
        try {
          snapshot = await postRef
              .limit(10)
              .orderBy('timeStamp', descending: true)
              .get();
          for (QueryDocumentSnapshot document in snapshot.docs) {
            documents.add(document);
            postItems.add(PostItem(user, post: Post.fromDocument(document)));
          }
        } catch (e) {
          print('error in fetch data in if block and more is $isMore');
          print(e.toString());
        }
      } else {
        try {
          snapshot = await postRef
              .limit(10)
              .orderBy('timeStamp', descending: true)
              .startAfterDocument(documents[documents.length - 1])
              .get()
              .then((value) {
            for (QueryDocumentSnapshot document in value.docs) {
              documents.add(document);
              postItems.add(PostItem(
                widget.user,
                post: Post.fromDocument(document),
              ));
            }
            return;
          });
        } catch (e) {
          print('error in fetch data in else block and more is $isMore');
          print(e.toString());
        }
      }
      if (snapshot.docs.length < 10) {
        setState(() {
          isMore = false;
        });
      }
    }
  }

  Future<void> refresh() async {
    setState(() {
      isMore = true;
      postItems.clear();
    });
    await fetchPosts(widget.user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'home',
        backgroundColor: secondaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewPost(user: widget.user)));
        },
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: SingleChildScrollView(
            controller: _scrollController,
            child: postItems.length == 0
                ? circularProgressIndicator().center()
                : Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 120,
                        color: backgroundColor.withOpacity(0.5),
                        child: RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Ubuntu'),
                              children: [
                                TextSpan(text: 'Fut'),
                                TextSpan(
                                    text: 'crick.',
                                    style: TextStyle(color: secondaryColor))
                              ]),
                        ).center(),
                      ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: postItems.length,
                        itemBuilder: (context, index) {
                          return Column(children: [
                            postItems[index],
                            SizedBox(
                              height: 20,
                            )
                          ]);
                        },
                      ),
                      // GridView.builder(
                      //   padding: EdgeInsets.zero,
                      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //       crossAxisCount: 1,
                      //       mainAxisSpacing: 20,
                      //       childAspectRatio: 0.93),
                      //   itemBuilder: (context, index) => postItems[index],
                      //   shrinkWrap: true,
                      //   itemCount: postItems.length,
                      //   scrollDirection: Axis.vertical,
                      //   physics: NeverScrollableScrollPhysics(),
                      // ),
                      SizedBox(height: 20),
                      Text(isMore ? 'Loading...' : 'End of page.').center(),
                      SizedBox(height: isMore ? 10 : 50),
                    ],
                  )),
      ),
    );
  }
}
