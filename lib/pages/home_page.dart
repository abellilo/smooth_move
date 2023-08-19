import 'package:flutter/material.dart';
import 'package:smooth_move/home_page.dart';
import 'package:smooth_move/intro_screens/intro_page_1.dart';
import 'package:smooth_move/intro_screens/intro_page_2.dart';
import 'package:smooth_move/intro_screens/intro_page_3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _controller = PageController();

  //keep track if your on the last page
  bool onlastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index){
              setState(() {
                onlastPage = (index == 2);
              });
            },
            children: [
              IntroPage1(),
              IntroPage2(),
              IntroPage3()
            ],
          ),
          Container(
            alignment: Alignment(0,0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //skip
                GestureDetector(
                    onTap:(){
                      _controller.jumpToPage(2);
                    },
                    child: Text("skip")
                ),

                SmoothPageIndicator(
                  effect: ExpandingDotsEffect(),
                    controller: _controller, count: 3
                ),

                //next
                onlastPage ?
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return Welcome();
                      }));
                    },
                    child: Text("done")
                )
                    :GestureDetector(
                    onTap: (){
                      _controller.nextPage(duration: Duration(milliseconds: 400), curve: Curves.easeIn);
                    },
                    child: Text("next")
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
