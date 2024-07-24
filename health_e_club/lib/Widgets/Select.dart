

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Select extends StatefulWidget {
  final List<String> reportList;
  final Function(String) onSelectionChanged;

  const Select(this.reportList, {required this.onSelectionChanged});

  @override
  _SelectState createState() => _SelectState();
}

class _SelectState extends State<Select> {
  String selectedChoice = "";

  _buildChoiceList() {
    List<Widget> choices = [];
    for (var item in widget.reportList) {
      choices.add(ChoiceChip(
        backgroundColor: Colors.white,
        selectedColor: Colors.blue,
        label: Text(item),
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        selected: selectedChoice == item,
        onSelected: (selected) {
          setState(() {
            selectedChoice = item;
            widget.onSelectionChanged(selectedChoice);
          });
        },
      ));
    }
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
