import 'package:ReachUp/Component/DatabaseRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sqflite/sqflite.dart';
import 'View/HomeView/Home.view.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_codegen/builder.dart';
import 'package:flame/util.dart';
import 'package:flutter/services.dart';
import 'mapRender.dart';

void main() async {
  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);

  MapRender map = MapRender();
  runApp(MyApp());
  runApp(map.widget);
}

var darkTheme = ThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF008D9E),
    onPrimary: Colors.white,
    primaryVariant: Color(0xFF006d7a),
    secondary: Color(0xFF006d7a),
    onSecondary: Colors.white,
    secondaryVariant: Colors.white,
    background: Colors.white,
    onBackground: Color(0xFF212121),
    error: Color(0xFFd42839),
    onError: Colors.white,
    surface: Color(0xFF212121),
    onSurface: Colors.white,
  ),
  appBarTheme: AppBarTheme(
    centerTitle: true,
    color: Color(0xFF008D9E),
  ),
  textTheme: TextTheme(
    bodyText1:
        TextStyle(fontSize: 24.0, fontFamily: 'Hind', color: Color(0xFF212121)),
    bodyText2:
        TextStyle(fontSize: 12.0, fontFamily: 'Hind', color: Color(0xFF212121)),
    headline1: TextStyle(
        fontSize: 24.0, fontFamily: 'Hind', fontWeight: FontWeight.bold),
    headline6: TextStyle(
        fontSize: 12.0, fontFamily: 'Hind', fontStyle: FontStyle.italic),
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

var lightTheme = ThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF008D9E),
    onPrimary: Colors.white,
    primaryVariant: Color(0xFF006d7a),
    secondary: Color(0xFF006d7a),
    onSecondary: Colors.white,
    secondaryVariant: Colors.white,
    background: Colors.white,
    onBackground: Color(0xFF525252),
    error: Color(0xFFd42839),
    onError: Colors.white,
    surface: Color(0xFF212121),
    onSurface: Colors.white,
  ),
  appBarTheme: AppBarTheme(
    centerTitle: true,
    color: Color(0xFF008D9E),
  ),
  textTheme: TextTheme(
    bodyText1:
        TextStyle(fontSize: 24.0, fontFamily: 'Hind', color: Color(0xFF212121)),
    bodyText2:
        TextStyle(fontSize: 12.0, fontFamily: 'Hind', color: Color(0xFF212121)),
    headline1: TextStyle(
        fontSize: 24.0, fontFamily: 'Hind', fontWeight: FontWeight.bold),
    headline6: TextStyle(
        fontSize: 12.0, fontFamily: 'Hind', fontStyle: FontStyle.italic),
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReachUp!',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: Home(),
    );
  }
}

//Pages Transitions
class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return new SlideTransition(
      position: Tween(begin: Offset(1, 0.0), end: Offset(0.0, 0.0))
          .animate(animation),
      child: child,
    );
  }
}

/// SQLite Connection

class _SqfLiteCrudState extends State<SqfLiteCrud> {
  final _formKey = GlobalKey<FormState>();
  Future<List<Todo>> future;
  String name;
  String id;

  @override
  initState() {
    super.initState();
    future = DatabaseRepository.getAllTodos();
  }

  void readData() async {
    final todo = await DatabaseRepository.getTodo(id);
    print(todo.name);
  }

  updateTodo(Todo todo) async {
    todo.name = 'Bananas!';
    await DatabaseRepository.updateTodo(todo);
    setState(() {
      future = DatabaseRepository.getAllTodos();
    });
  }

  deleteTodo(Todo todo) async {
    await DatabaseRepository.deleteTodo(todo);
    setState(() {
      id = null;
      future = DatabaseRepository.getAllTodos();
    });
  }
}
