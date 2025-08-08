import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tasks_app/register_form.dart';

// Create a Form widget.
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class LoginFormState extends State<LoginForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<LoginFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String? _email;
    String? _password;

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
                onSaved: (newValue) => _email = newValue,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'example.smith@gmail.com',
                  labelText: 'Dirección de correo',
                ),
                keyboardType:
                    TextInputType.emailAddress, // Suggests email keyboard
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingresa una dirección de correo';
                  }
                  // Basic email validation using a regular expression
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Verifica tu dirección de correo';
                  }
                  return null; // Input is valid
                },
              ),
              TextFormField(
                onSaved: (newValue) => _password = newValue,
                obscureText: true,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Almenos 6 caracteres incluyendo numeros y letras minuctulas y mayusculas';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'No uses tu nombre o correo para tu contraseña',
                  labelText: 'Contraseña *',
                ),
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
                      var url = Uri.http('192.168.1.10:3000', '/auth/login');
                      var response = await http.post(
                        url,
                        body: {'email': _email, 'password': _password},
                      );
                      print(response);
                      _formKey.currentState?.reset();
                    }
                  },
                  child: const Text('Login'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  onPressed: () async {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterForm()),
                    );
                    _formKey.currentState?.reset();
                  },
                  child: const Text('Registrar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
