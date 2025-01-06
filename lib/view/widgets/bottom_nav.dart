import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatefulWidget{
  const BottomNavigationBarWidget({super.key});
  
  @override
  State<BottomNavigationBarWidget> createState() => _BottomNavigationState() ;
}

class _BottomNavigationState extends State<BottomNavigationBarWidget>{
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(items: [],);
  }
}