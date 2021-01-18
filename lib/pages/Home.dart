import 'package:flutter/material.dart';
import 'package:futcrick/datamodel/Post.dart';
import 'package:futcrick/Extension.dart';

import '../Constants.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: RichText(
                    text: TextSpan(style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700, fontFamily: 'Ubuntu'),children: [
                      TextSpan(text: 'Fut'),
                      TextSpan(text: 'crick.', style: TextStyle(color: secondaryColor))
                    ]),
                  )).padding(left: 35,right: 35,top: 35, bottom: 35),

              PostItem(post: Post('WHAT DID CSK CEO KASI VISHWANATHAN SAID', 'CSK HAS NEVER BOUGHT OR RELEASED PLAYERS IN MID-SEASON TRANSFER WINDOW AND WE HAVE HONESTLY NOT EVEN GONE THROUGH THE RULES AND REGULATIONS THAT COME INTO PLAY IF YOU ARE LOOKING FOR A TRANSFER . WE ARE NOT LOOKING AT ANY PLAYER', 'Csk are finally back to  winning track as they registered an allround winning performance against the hyderabad . It seemed to be a good move that Curran was sent to the opening. He gave a blitzkrieg start but couldn\'t extend his role . Whatever but he did his role both with bat and ball . He seems to be a promising prospect for the daddies army.'
                  +'\nNow let\'s move on to our subject csk ceo spoke to ani , that the conditions in uae have forced us to go with two proper foreign batsman at top and then the two pace bowling allrounders. '
                  +'\nThen speaking about Imran tahir , the last season purple cap holder . He said that , " He will definitely come into the picture as we go ahead. Right now,  with the conditions on offer the team composition has been planned with two foreigners at top as pure batsmen and then two pace bowling allrounders . But he will come in with the wickets starting to take a turn in the second half . You have the four foreigner restrictions so you always plan according to the conditions on offer \" .'
                  +'\nThen tahir himself addressed how this season is going for him " It has been difficult sitting out , but you have to be honest,  I am enjoying and I know how we go about it as a team . I am happy if we are doing well as a team and waiting for the opportunity and hopefully will be ready when I get it . Will be a good challenge playing Against the young Indian talent . I see the pitches have started turning a little bit \"'
                  +'\nSpeaking about the mid-season transfer window moves , csk can bring in some Indian middle order batsmen to strengthen their batting unit as they are missing the likes of raina out there . But the csk ceo made it almost clear that they aren\'t looking for the mid-season transfers.'
                  +'\nHe said  that , " CSK HAS NEVER BOUGHT OR RELEASED PLAYERS IN MID-SEASON TRANSFER WINDOW AND WE HAVE HONESTLY NOT EVEN GONE THROUGH THE RULES AND REGULATIONS THAT COME INTO PLAY IF YOU ARE LOOKING FOR A TRANSFER . WE ARE NOT LOOKING AT ANY PLAYER \"'
                  +'\nHe also added that its a competition after all and I don\'t think any one would loan you players . Some might be playing and some would not , they did buy those with lots of permutations and combinations . So all Players are bought for numerous conditions that may arise . We don\'t go alone with plan A , if plan A doesn\'t work , then you have plan B , plan C , plan D .'
                  +'\nThus he made it clear that they aren\'t looking for any mid-season transfers .', 'https://cdn.dnaindia.com/sites/default/files/styles/full/public/2020/03/04/896577-ms-dhoni-afp.jpg', 69, 35, true, Map()), width: width)
            ],
          ),
        )
    );
  }
}
