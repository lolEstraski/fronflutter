import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Create a Form widget.
class RegisterTaskForm extends StatefulWidget {
  const RegisterTaskForm({super.key});

  @override
  RegisterTaskFormState createState() {
    return RegisterTaskFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class RegisterTaskFormState extends State<RegisterTaskForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<RegisterTaskFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String? _desc;
    String? _title;
    String? _token;
    bool? _isComplete;

    // Build a Form widget using the _formKey created above.
    return Scaffold(
      // The Scaffold
      appBar: AppBar(title: Text('My Form Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                onSaved: (newValue) => _token = newValue,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Token es requerido';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Token obtenido despeus de login',
                  labelText: 'Token',
                ),
              ),
              TextFormField(
                onSaved: (newValue) => _desc = newValue,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La descripción de la tarea es obligatoria';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Pasos a seguir para completar esta tarea',
                  labelText: 'Descripción',
                ),
              ),
              TextFormField(
                onSaved: (newValue) => _title = newValue,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Tarea #1',
                  labelText: 'Titulo de tarea *',
                ),
                keyboardType:
                    TextInputType.emailAddress, // Suggests email keyboard
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'El título de la tarea es obligatoria';
                  }
                  return null;
                },
              ),
              CheckboxListTile(
                title: Text('Completada:'),
                value: false,
                onChanged: (value) => _isComplete = value,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  onPressed: () async {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Procesando su registro')),
                      );
                      var url = Uri.http('192.168.1.3:3000', '/tasks');
                      var response = await http.post(
                        url,
                        headers: <String, String>{
                          'Authorization':
                              'Bearer $_token', // Include the bearer token here
                        },
                        body: {'description': _desc, 'title': _title},
                      );
                      print(response);
                      _formKey.currentState?.reset();
                    }
                  },
                  child: const Text('Crear tarea'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}