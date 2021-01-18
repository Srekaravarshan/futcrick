
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'datamodel/Post.dart';

Color backgroundColor = Color(0xFF1A1A1A);
Color secondaryColor = Color(0xFFFF7357);
Color secondaryDark = Color(0xFFFC5956);
Color iconColor = Color(0xFFE62622);
Color yellowColor = Color(0xFFFFE957);
Color blueColor = Color(0xFF004CFF);

Widget listItem({IconData icon, String title, Function onPressed}){
  return InkWell(
    splashColor: Colors.white.withOpacity(0.1),
    onTap: onPressed,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor,size: 24),
              SizedBox(width: 18),
              Text(title, style: TextStyle(fontSize: 18, fontFamily: 'Ubuntu'))
            ],
          ),
          Icon(Icons.arrow_forward_ios_rounded, color: iconColor)
        ],
      ),
    ),
  );
}

Widget post(Post post, double width){

  bool _isLiked = false;

  return Container(
    width: width,
    margin: EdgeInsets.symmetric(horizontal: 30),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(8))
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 130,
          decoration: BoxDecoration(
            color: yellowColor,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            image: DecorationImage(image: NetworkImage(post.url), fit: BoxFit.cover)
          ),
        ),
        SizedBox(height: 10),
        Text(post.title, style: TextStyle(color: backgroundColor, fontFamily: 'Ubuntu', fontSize: 22, fontWeight: FontWeight.w700), maxLines: 2, overflow: TextOverflow.ellipsis,),
        SizedBox(height: 5),
        Text(post.content, style: TextStyle(color: backgroundColor, fontFamily: 'FiraSans', fontSize: 16), maxLines: 3, overflow: TextOverflow.ellipsis,),
        SizedBox(height: 10),
        Row(
          children: [
            IconButton(icon: Icon(Icons.favorite_border_rounded), splashColor: secondaryColor, color: iconColor, onPressed: () {

            }),
            Text(post.likeCount.toString(), style: TextStyle(color: Colors.black54),),
            SizedBox(width: 10),
            IconButton(icon: Icon(Icons.message, color: blueColor),splashColor: secondaryColor, onPressed: () {},),
            Text(post.commentCount.toString(), style: TextStyle(color: Colors.black54)),
          ],
        ),
      ],
    )
  );
}

class PostItem extends StatefulWidget {

  final Post post;
  final double width;

  const PostItem({Key key, this.post, this.width}) : super(key: key);

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {

  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.width,
        margin: EdgeInsets.symmetric(horizontal: 30),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 130,
              decoration: BoxDecoration(
                  color: yellowColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                  image: DecorationImage(image: NetworkImage(widget.post.url), fit: BoxFit.cover)
              ),
            ),
            SizedBox(height: 10),
            Text(widget.post.title, style: TextStyle(color: backgroundColor, fontFamily: 'Ubuntu', fontSize: 22, fontWeight: FontWeight.w700), maxLines: 2, overflow: TextOverflow.ellipsis,),
            SizedBox(height: 5),
            Text(widget.post.previewContent, style: TextStyle(color: backgroundColor, fontFamily: 'FiraSans', fontSize: 16), maxLines: 3, overflow: TextOverflow.ellipsis,),
            SizedBox(height: 10),
            Row(
              children: [
                IconButton(icon: Icon(isLiked ? Icons.favorite :Icons.favorite_border_rounded), splashColor: secondaryColor, color: iconColor, onPressed: () {
                  setState(() {
                    isLiked = true;
                  });
                }),
                Text(widget.post.likeCount.toString(), style: TextStyle(color: Colors.black54),),
                SizedBox(width: 10),
                IconButton(icon: Icon(Icons.message, color: blueColor),splashColor: secondaryColor, onPressed: () {},),
                Text(widget.post.commentCount.toString(), style: TextStyle(color: Colors.black54)),
              ],
            ),
          ],
        )
    );
  }
}

