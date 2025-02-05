// @dart=2.9
import 'package:ReachUp/Component/Database/Database.db.dart';
import 'package:ReachUp/Component/Dialog/CustomDialog.component.dart';
import 'package:ReachUp/View/DeveloperView/BeaconBroadcast.view.dart';
import 'package:ReachUp/View/DeveloperView/Compass.view.dart';
import 'package:ReachUp/View/FeedbackView/Feedback.view.dart';
import 'package:ReachUp/View/HomeView/HomeMap.view.dart';
import 'package:ReachUp/View/HomeView/WalkingInfo.view.dart';
import 'package:ReachUp/View/InfoView/Info.view.dart';
import 'package:ReachUp/View/MapView/Map.view.dart';
import 'package:ReachUp/View/NarratorConfigView/NarratorConfig.view.dart';
import 'package:ReachUp/View/NotificationsView/Notifications.view.dart';
import 'package:ReachUp/View/ProfileView/Profile.view.dart';
import 'package:ReachUp/View/SearchView/Search.view.dart';
import 'package:ReachUp/View/SignView/Sign.view.dart';
import 'package:ReachUp/View/_Layouts/HomeLayout.layout.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../globals.dart';
import '../../main.dart';

class FragmentWidget extends StatelessWidget {
  Widget contentWidget;
  FragmentWidget(this.contentWidget);

  @override
  Widget build(BuildContext context) => contentWidget;
}

class Home extends StatefulWidget {
  bool inRouting;
  bool isNoob;

  Home({this.inRouting = false, this.isNoob = false});
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  Widget _getDrawerItem(int pos) {
    switch (pos) {
      case 0:
        return FragmentWidget(MapView(inRouting: widget.inRouting));

      case 7:
        return FragmentWidget(BroadcastBeacon());
      case 8:
        return FragmentWidget(Compass());
    }
  }

  _onSelectItem(int index) {
    Navigator.of(context).pop();
    setState(() => _selectedIndex = index);
  }

  createAlertDialog(
      BuildContext context, String title, String msg, IconData icon) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => CustomDialog(
            icon: icon,
            title: title,
            description: msg,
            buttonOK: RaisedButton(
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                msg,
                style: TextStyle(color: Colors.white),
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              Container(
                height: 130,
                child: DrawerHeader(
                  margin: EdgeInsets.all(0.0),
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
                  child: GestureDetector(
                    onTap: () {
                      navigateTo(
                          ProfileView(),
                          "Perfil",
                          "Aqui você verificar as informações do seu perfil, bem como editá-las",
                          context,
                          false);
                    },
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          bottom: 0,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: FaIcon(
                                  FontAwesomeIcons.userAlt,
                                  color: Colors.white,
                                  size: 45,
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      child: Text(Globals.user.name,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondary,
                                              fontSize: 25))),
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: Opacity(
                                        opacity: 0.5,
                                        child: Text(Globals.user.email,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondary,
                                                fontSize: 16)),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.primaryVariant
                      ])),
                ),
              ),
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  // Important: Remove any padding from the ListView.
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          ListTile(
                            selected: true,
                            contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 10),
                            title: ItemMenuTitle(
                                title: "Mapa",
                                icon: FontAwesomeIcons.mapMarked,
                                selected: _selectedIndex == 0),
                            onTap: () {
                              _onSelectItem(0);
                            },
                          ),
                          ListTile(
                              contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 10),
                              title: ItemMenuTitle(
                                  title: "Anúncios",
                                  icon: FontAwesomeIcons.solidBell,
                                  selected: _selectedIndex == 1),
                              onTap: () {
                                navigateDirectly(
                                    NotificationsView(), context, false);
                              }),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border(
                              top: BorderSide(
                                  width: 1.0, color: Color(0xFFededed)),
                            )),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(15, 10, 0, 15),
                              child: const Text(
                                "Definições",
                                style:
                                    TextStyle(fontSize: 18, color: Colors.grey),
                              ),
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 10),
                            title: ItemMenuTitle(
                                title: "Narrador",
                                icon: FontAwesomeIcons.headset,
                                selected: _selectedIndex == 3),
                            onTap: () {
                              navigateTo(
                                  NarratorConfig(),
                                  "Narrador",
                                  "Aqui você pode alterar suas configurações do narrador de voz",
                                  context,
                                  false);
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border(
                              top: BorderSide(
                                  width: 1.0, color: Color(0xFFededed)),
                            )),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(15, 10, 0, 15),
                              child: const Text(
                                "Contato",
                                style:
                                    TextStyle(fontSize: 18, color: Colors.grey),
                              ),
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 10),
                            title: ItemMenuTitle(
                                title: "Feedback",
                                icon: FontAwesomeIcons.solidStar,
                                selected: _selectedIndex == 5),
                            onTap: () {
                              navigateTo(
                                  FeedbackView(),
                                  "Feedback",
                                  "Aqui você pode dar seu feedback e colaborar com o projeto",
                                  context,
                                  false);
                            },
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 10),
                            title: ItemMenuTitle(
                                title: "Info",
                                icon: FontAwesomeIcons.infoCircle,
                                selected: _selectedIndex == 6),
                            onTap: () {
                              navigateTo(InfoView(), "Info", "Quem somos nós?",
                                  context, false);
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border(
                              top: BorderSide(
                                  width: 1.0, color: Color(0xFFededed)),
                            )),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(15, 10, 0, 15),
                              child: const Text(
                                "Sair",
                                style:
                                    TextStyle(fontSize: 18, color: Colors.grey),
                              ),
                            ),
                          ),
                          ListTile(
                            selected: true,
                            focusColor: Colors.black,
                            contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 10),
                            title: ItemMenuTitle(
                                danger: true,
                                title: "Sair",
                                icon: FontAwesomeIcons.signOutAlt,
                                selected: _selectedIndex == 9),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => CustomDialog(
                                      title: "Sair",
                                      description: "Deseja sair?",
                                      buttonOK: RaisedButton(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          child: Text("Continuar",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          }),
                                      buttonNO: FlatButton(
                                          onPressed: () {
                                            Database.delete(key: "user");
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SignView()),
                                              (Route<dynamic> route) => false,
                                            );
                                          },
                                          child: Text(
                                            "Sair",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 19),
                                          )),
                                      icon: FontAwesomeIcons.signOutAlt));
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        endDrawer: Search(),
        appBar: AppBar(
            title: const Text(
              "ReachUp!",
              style: TextStyle(fontSize: 25),
            ),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.menu, size: 30),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
            actions: <Widget>[
              Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.notifications,
                        size: 30, color: Colors.white),
                    onPressed: () {
                      navigateDirectly(NotificationsView(), context, true);
                    },
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  ),
                  Positioned(
                    top: 3,
                    right: 3,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.red),
                      alignment: Alignment.center,
                      child: Text('0'),
                    ),
                  )
                ],
              ),
              Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.search, size: 30, color: Colors.white),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                ),
              ),
            ]),
        body: Container(
          child: Column(children: <Widget>[
            Expanded(
                child: Container(
                    child: Center(child: _getDrawerItem(this._selectedIndex)))),
            //Melhorar if ternário
            this._selectedIndex == 0
                ? Container(
                    width: double.infinity,
                    height: 45,
                    child: InkWell(
                        child: Container(
                          color: Theme.of(context).colorScheme.primary,
                          child: Center(
                            child: FaIcon(
                              FontAwesomeIcons.angleUp,
                              color: Colors.white,
                              size: 35.0,
                            ),
                          ),
                        ),
                        onTap: () {
                          showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                    child: Column(
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 45,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        child: Center(
                                          child: FaIcon(
                                            FontAwesomeIcons.angleDown,
                                            color: Colors.white,
                                            size: 35.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    WalkingInfoView()
                                  ],
                                ));
                              });
                        }))
                : Container()
          ]),
        ));
  }
}

class ItemMenuTitle extends StatelessWidget {
  String title;
  IconData icon;
  bool selected;
  bool danger;
  ItemMenuTitle({this.title, this.icon, this.selected, this.danger = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FaIcon(icon,
            size: 30,
            color: danger
                ? Theme.of(context).colorScheme.error
                : selected
                    ? Theme.of(context).colorScheme.primaryVariant
                    : Theme.of(context).colorScheme.onBackground),
        Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 20,
                  color: danger
                      ? Theme.of(context).colorScheme.error
                      : selected
                          ? Theme.of(context).colorScheme.primaryVariant
                          : Theme.of(context).colorScheme.onBackground),
            ))
      ],
    );
  }
}
