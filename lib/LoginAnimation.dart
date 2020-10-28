import 'package:flutter/material.dart';
import 'package:sdgs15/home.dart';

class StartAnimation extends StatefulWidget {
  StartAnimation({Key key, this.buttonController, this.user,this.pass})
  : shrinkButtonAnimation = new Tween(
    begin: 320.0,
    end: 70.0
  ).animate(CurvedAnimation(
    parent: buttonController,
    curve: Interval(
      0.0,
      0.150
    )
  ),
  ),
        zoomAnimation= new Tween(
            begin: 70.0,
            end: 900.0
        ).animate(CurvedAnimation(
            parent: buttonController,
            curve: Interval(
              0.550,
              0.999,
              curve: Curves.bounceOut,
            )
        )),

  super(key:key);

  final AnimationController buttonController;
  final Animation shrinkButtonAnimation;
  final Animation zoomAnimation;

  final String user;
  final String pass;

  Widget _buildAnimation(BuildContext context, Widget child){
  return Padding(
    padding: const EdgeInsets.only(bottom: 60.0),
    child:
    zoomAnimation.value<=300 ?
    new Container(
        alignment: FractionalOffset.center,
        width: shrinkButtonAnimation.value,
        height: 60.0,
        decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(const Radius.circular(30.0))
        ),
        child: shrinkButtonAnimation.value> 75
        ? Text("Sign In",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w300,
              letterSpacing: 0.3
          ),
        )
            : CircularProgressIndicator(strokeWidth: 1.0, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)
          ),)
    :user=='idr' ?
         Container(

      width: zoomAnimation.value,
      height: zoomAnimation.value,
      decoration: BoxDecoration(
        shape: zoomAnimation.value <600
          ? BoxShape.circle
          : BoxShape.rectangle,
        color: Colors.green,
      ),
    )
      :Container(
    alignment: FractionalOffset.center,
    width: shrinkButtonAnimation.value,
    height: 60.0,
    decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.all(const Radius.circular(30.0))
    ),
    child: shrinkButtonAnimation.value> 75
        ? Text("Sign In",
      style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.3
      ),
    )
        : CircularProgressIndicator(strokeWidth: 1.0, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)
    ),)
  );
  }

  @override
  _StartAnimationState createState() => _StartAnimationState();
}

class _StartAnimationState extends State<StartAnimation> {

  @override
  Widget build(BuildContext context) {
    widget.buttonController.addListener(() {
      if(widget.zoomAnimation.isCompleted){
        if (widget.user == 'idr'){
          Navigator.of(context).push(
            MaterialPageRoute(
            builder: (BuildContext contex) => new Home()
            )
          );
        }

      }
    });
    return new AnimatedBuilder(
      builder: widget._buildAnimation,
      animation: widget.buttonController,
    );
  }
}
