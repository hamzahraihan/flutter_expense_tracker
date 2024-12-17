import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter MVVM',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.white, brightness: Brightness.light),
        fontFamily: GoogleFonts.inter().fontFamily,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Expenses'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      centerTitle: true,
      title: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.5),
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Text(widget.title, style: const TextStyle(fontSize: 14.0)),
      ),
      leading: const Padding(
          padding: EdgeInsets.only(left: 16.0), child: CircleAvatar()),
      actions: [
        Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
                onPressed: () => {}, icon: const Icon(Icons.notifications)))
      ],
    );
    return Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Center(
                child: Text('Account Balances'),
              ),
              const Center(
                child: Text(
                  '\$9000',
                  style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                height: 200,
                child: GridView.count(
                  crossAxisSpacing: 10,
                  shrinkWrap: true,
                  childAspectRatio: 2,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: [
                    SizedBox(
                      height: 50,
                      child: Card(
                        color: Colors.teal[100],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Text("He'd have you all unravel at the"),
                        ),
                      ),
                    ),
                    Card(
                      color: Colors.teal[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Text("He'd have you all unravel at the"),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
