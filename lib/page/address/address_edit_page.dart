import 'package:flutter/material.dart';
import 'package:flutter_jdshop/models/address_model.dart';

class AddressEditPage extends StatefulWidget {
  final Map arguments;

  const AddressEditPage({Key key, this.arguments}) : super(key: key);

  @override
  _AddressEditPageState createState() => _AddressEditPageState();
}

class _AddressEditPageState extends State<AddressEditPage> {
  AddressModel _addressModel;

  @override
  void initState() {
    super.initState();
    _addressModel = widget.arguments['address'];
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
