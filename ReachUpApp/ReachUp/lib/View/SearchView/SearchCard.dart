import 'package:ReachUp/Component/Dialog/CustomDialog.component.dart';
import 'package:ReachUp/Model/Local.dart';
import 'package:ReachUp/Model/Subcategory.model.dart';
import 'package:ReachUp/View/HomeView/Home.view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class SearchCard extends StatefulWidget {
  final Local local;

  const SearchCard({Key key, @required this.local}) : super(key: key);

  @override
  _SearchCardState createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  createAlertDialog(BuildContext context, Local local) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => CustomDialog(
             icon: FontAwesomeIcons.mapMarkedAlt,
              title: "${local.name}",
              description: "Ir até ${local.name}?",
              buttonOK: IconButton(
                icon: Icon(Icons.check,  size: 40, color: Colors.green,),
                onPressed: (){
                    //chamar rota
                    Navigator.pop(context);
                    Navigator.pop(context, true);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Home(inRouting: true,),));
                    
                },
              ),
              buttonNO: IconButton(
                icon: Icon(Icons.close,  size: 40, color: Colors.red,),
                onPressed: (){
                    Navigator.pop(context);
                },
              ),
            ));
  }

  String showSubcategories() {
    String _r = "";
    List<String> subcats = widget.local.descriptionSubCategories.split(",");
    int i = 0;
    subcats.forEach((subcat) {
      if (i <= 2) _r += subcat + " ";
    });

    return _r;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          print("IDLOCAL: ${widget.local.idLocal}");
          createAlertDialog(context, widget.local);
        },
        child: Stack(
          children: [
            Row(children: <Widget>[
              Container(
                height: 125,
                width: MediaQuery.of(context).size.width * 0.30,
                decoration: BoxDecoration(
                  border: Border(
                      // right: BorderSide(width: 1.0, color: Colors.grey),
                      ),
                ),
                child: Center(
                  child: FaIcon(
                      widget.local.type == 0
                          ? FontAwesomeIcons.store
                          : widget.local.type == 1
                              ? FontAwesomeIcons.hamburger
                              : widget.local.type == 2
                                  ? FontAwesomeIcons.film
                                  : widget.local.type == 3
                                      ? FontAwesomeIcons.bath
                                      : widget.local.type == 4
                                          ? FontAwesomeIcons.lastfm
                                          : FontAwesomeIcons.store,
                      size: 40,
                      color: Color(0xFF545454)),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        width: 150,
                        child: Text(
                          widget.local.name,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        )),
                    Container(
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          showSubcategories(),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        )),
                  ],
                ),
              )
            ]),
            Positioned(
                top: 10,
                right: 10,
                child: widget.local.type == 0 ||
                        widget.local.type == 1 ||
                        widget.local.type == 2
                    ? FaIcon(FontAwesomeIcons.shoppingBag,
                        size: 25, color: Colors.orange)
                    : widget.local.type == 3
                        ? FaIcon(FontAwesomeIcons.bath,
                            size: 25, color: Colors.blue)
                        : null),
            Positioned(
                bottom: 10,
                right: 10,
                child: FaIcon(FontAwesomeIcons.doorOpen,
                    size: 25, color: Colors.green)),
          ],
        ),
      ),
    );
  }
}
