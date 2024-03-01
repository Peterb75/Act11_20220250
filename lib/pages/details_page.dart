import 'package:flutter/material.dart';
import 'package:movieapi/models/results.dart';

@RoutePage
class DetailPage extends  {
  const (super.key, this.results,
  );
final Results results;
  @override
   Widget build(  context){

   }
}

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, this.results});
  final Results results;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


//tittle text("result!.tittle");
