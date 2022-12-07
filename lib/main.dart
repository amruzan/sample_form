import 'package:flutter/material.dart';
import 'package:checkbox_formfield/checkbox_formfield.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Form Page Sample"),
        ),
        body: const FormPage(),
      ),
    );
  }
}

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final List<String> courses = ["Qualification", "Degree", "Masters", "Others"];
  String firstItem = "Select";
  final TextEditingController dob = TextEditingController();
  DateTime selectedDate = DateTime.now();
  bool light = false;
  bool checkboxValue = false;
  double sliderValue = 20;
  List chipOptions = ["Option1","Option2","Option3"];
  int? _value =1;
  String gender = "";
  bool checkboxFormFieldValue = false;

  void validationForm(){
    if(checkboxValue==false){

    }
  }

  Future<void> _setDate(BuildContext context) async {
   final DateTime? picker = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if(picker!=null){
      setState(() {
        selectedDate = picker;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(25),
            child: Column(
              children: [
                TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Name field required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)))),
                SizedBox(
                  height: 10,
                ),
                //   TextFormField(
                //     controller: dob,
                //     onSaved: (value){
                //       setState(() {
                //         dob.text=selectedDate.toIso8601String();
                //       });
                //
                //     },
                //     onTap: ()
                //     { _setDate(context);
                //     FocusScope.of(context).requestFocus(new FocusNode());
                //       setState(() {
                //         dob.text=selectedDate.toIso8601String();
                //       });
                //
                //       },
                //     decoration: InputDecoration(
                //         labelText: "D.O.B.",
                //         border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(20))),
                //   ),
                // InkWell(onTap: ()=>_setDate(context),
                //   child: InputDatePickerFormField(
                //
                //       initialDate: selectedDate,
                //       firstDate: DateTime(1900),
                //       lastDate: DateTime.now(),
                //       onDateSubmitted: (date){
                //         setState(() {
                //
                //           selectedDate = date;
                //         });
                //       },
                //       fieldLabelText: "Enter DOB"),
                // ),
                Container(padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Wrap(
                      children: [Text("Gender",style: TextStyle(fontWeight: FontWeight.bold),),
                  RadioListTile(title: Text("male"),
                      value: "Male", groupValue: gender, onChanged: (val){
                    setState(() {
                      gender = val!;
                    });
                  }),
                    RadioListTile(title: Text("Female"),
                        value: "Female", groupValue: gender, onChanged: (val){
                      setState(() {
                        gender = val!;
                      });
                    })]),
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    validator: (value) {
                      if (value == "Qualification") {
                        return "Select your qualification";
                      }
                      return null;
                    },
                    value: courses.first,
                    items:
                        courses.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem(value: value, child: Text(value));
                    }).toList(),
                    onChanged: (values) {
                      setState(() {
                        print(values);
                      });
                    }),
                SizedBox(height: 10,),
                Slider(
                  divisions: 5,
                    max: 100,
                    value: sliderValue, onChanged: (value){
                  setState(() {
                    sliderValue=value;
                  });
                    },
                label: sliderValue.toString()+"k",),
                SizedBox(height: 10,),
                Wrap(
                  children: List<Widget>.generate(
                    chipOptions.length,
                        (int index) {
                      return ChoiceChip(
                        label: Text(chipOptions[index]),
                        selected: _value == index,
                        onSelected: (bool selected) {
                          setState(() {
                            _value = selected ? index : null;
                          });
                        },
                      );
                    },
                  ).toList(),
                ),
                SizedBox(height: 10,),
                Row(children: [
                  Text("Save the Data?",style: TextStyle(fontSize: 20),),
                  Switch(value: light, onChanged: (value){
                    setState(() {
                      light=value;
                    });
                  })
                ],),
                // SizedBox(height: 10,),
                // Container(decoration: BoxDecoration(border: Border.all(color: Colors.black),
                //     borderRadius: BorderRadius.all(Radius.circular(20))),
                //   child: CheckboxListTile(
                //       title: Text("Agree to the terms and conditions"),
                //       value: checkboxValue, onChanged: (value){setState(() {
                //     checkboxValue=value!;
                //   });}),
                // ),
                SizedBox(height: 10,),
                CheckboxListTileFormField(
                  context: context,
                  title: Text("Agree to terms and conditions"),
                  initialValue: checkboxFormFieldValue,
                  onChanged: (value){
                    setState(() {
                      checkboxFormFieldValue=!checkboxFormFieldValue;
                    });
                  },
                  validator: (_){
                    if(checkboxFormFieldValue==false){
                      return "Check the box to proceed";
                    }
                    else
                      return null;
        },
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                    child: Text("Submit"),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')));
                      }
                    })
              ],
            ),
          ),
        ));
  }
}
