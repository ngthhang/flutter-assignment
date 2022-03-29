import "package:flutter/material.dart";

class AppTitle extends StatefulWidget {
  const AppTitle({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<AppTitle> createState() => _AppTitleState();
}

class _AppTitleState extends State<AppTitle> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(widget.title,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 35,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins')),
      const Text('.',
          style: TextStyle(
            color: Colors.yellow,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          )),
    ]);
  }
}
