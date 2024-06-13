import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter_localizations/flutter_localizations.dart';

class MyLocalizations {
  MyLocalizations(this.locale);

  final Locale locale;

  static MyLocalizations of(BuildContext context) {
    return Localizations.of<MyLocalizations>(context, MyLocalizations)!;
  }

  static const _localizedValues = <String, Map<String, String>>{
    'en': {
      'title': 'BMI',
      'text_height': 'Height(m):',
      'text_weight': 'Weight(kg):',
      'tf_hint_weight': 'Enter your weight in KG',
      'tf_hint_height': 'Enter your height in meter',
      'bn_calculate': 'calculate',
    },
    'zh': {
      'title': 'BMI',
      'text_height': '身高(公尺):',
      'text_weight': '體重(公斤):',
      'tf_hint_weight': '輸入幾公斤',
      'tf_hint_height': '輸入幾公尺',
      'bn_calculate': '計算',
    },
  };

  static List<String> languages() => _localizedValues.keys.toList();

  String get title {
    return _localizedValues[locale.languageCode]!['title']!;
  }

  String get text_height {
    return _localizedValues[locale.languageCode]!['text_height']!;
  }

  String get text_weight {
    return _localizedValues[locale.languageCode]!['text_weight']!;
  }

  String get tf_hint_weight {
    return _localizedValues[locale.languageCode]!['tf_hint_weight']!;
  }

  String get tf_hint_height {
    return _localizedValues[locale.languageCode]!['tf_hint_height']!;
  }

  String get bn_calculate {
    return _localizedValues[locale.languageCode]!['bn_calculate']!;
  }
}

class MyLocalizationsDelegate
    extends LocalizationsDelegate<MyLocalizations> {
  const MyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      MyLocalizations.languages().contains(locale.languageCode);

  @override
  Future<MyLocalizations> load(Locale locale) {
    return SynchronousFuture<MyLocalizations>(MyLocalizations(locale));
  }

  @override
  bool shouldReload(MyLocalizationsDelegate old) => false;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => MyLocalizations.of(context).title,
      localizationsDelegates: const [
        MyLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('zh', ''),
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _bmi = 0.0;
  double _height = 1.0;
  double _weight = 0.0;
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  void _calculateBmi() {
    setState(() {
      if ((weightController.text == '') || (heightController.text == '')) {
        return;
      }
      _weight = double.parse(weightController.text);
      _height = double.parse(heightController.text);
      _bmi = _weight / (_height * _height);
    });
  }

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(MyLocalizations.of(context).title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Text(MyLocalizations.of(context).text_height),
              Expanded(
                child: TextField(
                  controller: heightController,
                  decoration: InputDecoration(
                    hintText: MyLocalizations.of(context).tf_hint_height,
                  ),
                ),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Text(MyLocalizations.of(context).text_weight),
              Expanded(
                child: TextField(
                  controller: weightController,
                  decoration: InputDecoration(
                    hintText: MyLocalizations.of(context).tf_hint_weight,
                  ),
                ),
              ),
            ]),
            ElevatedButton(
                onPressed: _calculateBmi, child: Text(MyLocalizations.of(context).bn_calculate)),
            Text('bmi: ${_bmi.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}
