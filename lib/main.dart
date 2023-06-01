import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';

var kcolorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 180)
);
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,// to say that this seed clr is used for dark mode
  seedColor: const Color.fromARGB(255, 5, 99, 125)
);
//k is used as prefix of variable names to indicate global scope, mostly used for theme variables
void main(){
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        cardTheme:const  CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8)
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer
          )
        ),
      ),
      themeMode: ThemeMode.system,
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kcolorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kcolorScheme.onPrimaryContainer,
          foregroundColor: kcolorScheme.primaryContainer,
          centerTitle: false,
          //titleTextStyle: TextStyle(fontSize: 25,color: kcolorScheme.primary),
        ),
        cardTheme:const  CardTheme().copyWith(
          color: kcolorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8)
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kcolorScheme.primaryContainer
          )
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            color: kcolorScheme.onSecondaryContainer,
            fontSize: 16,
            fontWeight: FontWeight.bold
          )
        )
      ),
      home: const Expenses(),
    )
  );
}