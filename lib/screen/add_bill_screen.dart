import 'dart:io';

import 'package:flutter/material.dart';
import 'package:om_bills/widgets/image_input.dart';

class AddBillScreen extends StatefulWidget {
  static const routeName = '/AddBillScreen';

  @override
  _AddBillScreenState createState() => _AddBillScreenState();
}

class _AddBillScreenState extends State<AddBillScreen> {
  var _formKey = GlobalKey<FormState>();
  var _name = '';
  var _phone = '';
  var _notes = '';

  var _isLoading = false;
  var _imagePicked;
  var _image = false;

  void _getImage(File imageFile) {
    _imagePicked = imageFile;
  }

  void _saveForm(BuildContext context) async {
    setState(() {
      _isLoading = true;
      _image = false;
    });
    FocusScope.of(context).unfocus();
    if (_imagePicked == null) {
      setState(() {
        _image = true;
      });
    }
    if (!_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = false;
      });
      return;
    } else {
      if (_imagePicked == null) {
        setState(() {
          _isLoading = false;
        });
        return;
      }
      _formKey.currentState!.save();
      print(_phone);
      print(_name);
      print(_notes);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Bill'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Phone',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter phone no.";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          _phone = value!;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Name',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter name";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          _name = value!;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ImageInput(_getImage),
                      SizedBox(
                        height: 5,
                      ),
                      if (_image)
                        Text(
                          'Please take image',
                          style: TextStyle(
                            color: Colors.red[700],
                            fontSize: 12,
                          ),
                        ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Notes',
                        ),
                        onSaved: (value) {
                          if (value!.isEmpty)
                            _notes = '-';
                          else
                            _notes = value;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          _isLoading
              ? Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: CircularProgressIndicator(),
                )
              : ButtonTheme(
                  minWidth: double.infinity,
                  child: RaisedButton.icon(
                    onPressed: () => _saveForm(context),
                    icon: Icon(Icons.add),
                    label: Text('Add Bill'),
                    elevation: 0,
                    color: Theme.of(context).accentColor,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
        ],
      ),
    );
  }
}
