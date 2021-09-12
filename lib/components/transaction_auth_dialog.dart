import 'package:flutter/material.dart';

class TransactionAuthDialog extends StatelessWidget {
  const TransactionAuthDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Authenticate'),
      content: TextField(
        obscureText: true,
        maxLength: 4,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        style: TextStyle(
          fontSize: 64,
          letterSpacing: 32,
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        FlatButton(onPressed: () => print('cancel'), child: Text('Cancel')),
        FlatButton(onPressed: () => print('confirm'), child: Text('Confirm')),
      ],
    );
  }
}
