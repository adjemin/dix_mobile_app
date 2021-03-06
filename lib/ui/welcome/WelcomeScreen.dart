import 'dart:async';

import 'package:dixapp/models/Session.dart';
import 'package:dixapp/ui/auth/RegisterScreen.dart';
import 'package:dixapp/ui/main/MainScreen.dart';
import 'package:dixapp/ui/welcome/slide/SlideWidget.dart';
import 'package:dixapp/ui/widgets/Button.dart';
import 'package:dixapp/util/LoginManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';

class WelcomeScreen extends StatefulWidget {

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  int _index = 0;

  double size = 12.0;
  double activeSize = 12.0;

  PageController controller;

  @override
  void initState() {
    controller = PageController();
    controller.addListener(() {
      double page = controller.page;
      _index = page.round();
      //_index = page;
    });
    super.initState();

    Timer.run(() {

      LoginManager.connectedUser()
          .then((Session value)async{

        if(value != null){

          print('Connected $value');

          LoginManager.findContacts()
              .then((contactResult){
            print('Connected >>> contactResult $contactResult');

            if(contactResult != null){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MainScreen(value,contactResult)));
            }

          });


        }
      }).catchError((onError){

      });

    });

  }


  @override
  Widget build(BuildContext context) {

    var children = <Widget>[
      new SlideWidget(
        image: 'images/slide_1.png',
        title: "Passez de 8 à 10 chiffres tous vos numéros de téléphones Ivoiriens ",
        description: "Le nouveau Plan National de Numérotation (PNN) prévoit qu’on ajoute simplement le ‘’07’’, préfixe devant les anciens numéros d’Orange ; le ‘’05’’, devant ceux de MTN ; et le ‘’01’’, devant les anciens numéros de Moov. « Pour les numéros fixes, il faudra ajouter le ‘’27’’ devant les anciens numéros d’Orange ; le‘’25’’ devant les anciens numéros de MTN ; le ‘’21’’ devant les anciens numéros de Moov",
      ),
      new SlideWidget(
        image: 'images/slide_2.png',
        title: "Partagez votre expérience avec vos proches ",
        description: "Faites découvrir l'application à vos proches en partageant un lien sur les réseaux sociaux.",

      )
    ];
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Expanded(
                child: Stack(
                  children: <Widget>[
                    PageView(
                      controller: controller,
                      children: children,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: PageIndicator(
                          layout: PageIndicatorLayout.DROP,
                          color: Colors.grey[300],
                          size: size,
                          activeColor: Theme.of(context).primaryColor,
                          activeSize: activeSize,
                          controller: controller,
                          space: 5.0,
                          count: children.length,
                        ),
                      ),
                    )
                  ],
                )),


            new Button(
              width: MediaQuery.of(context).size.width,
              title: "SUIVANT",
              color: Theme.of(context).accentColor,
              titleColor: Colors.white,
              titleSize: 20,
              margin: EdgeInsets.only(left: 25.0, right: 25.0, top: 10),
              onTap: (){
               onNext();
              },
            ),

            new SizedBox(height: 20,)
          ],
        ));

    ;
  }

  void onNext() {

    if(_index == 1){

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> new RegisterScreen()));

    }else{
      _index ++;
      controller.jumpToPage(_index);
    }



  }

}
