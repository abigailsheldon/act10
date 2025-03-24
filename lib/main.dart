import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Form Validation Demo';
    return MaterialApp(
      title: appTitle,
      initialRoute: '/',
      routes: {
        '/': (context) => const SignupPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // Global key to identify form and save form data for validation
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Signup Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // FormBuilder wraps the form and handles state
        child: FormBuilder(
          // Global key
          key: _formKey,
          child: Column(
            children: <Widget>[
              // FormBuilderTextField for text input: name, email, password
              
              // Name input
              FormBuilderTextField(
                name: 'name',
                decoration: const InputDecoration(labelText: 'Name'),
                // Input validation 
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context,
                      errorText: 'Name required'),
                ]),
              ),
              
              // Email input
              FormBuilderTextField(
                name: 'email',
                decoration: const InputDecoration(labelText: 'Email'),
                // Validation
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context,
                      errorText: 'Email required'),
                  FormBuilderValidators.email(context,
                      errorText: 'Please enter a valid email'),
                ]),
              ),
              
              // FormBuilderDateTimePicker for DOB
              // DOB
              FormBuilderDateTimePicker(
                name: 'dob',
                inputType: InputType.date,
                decoration: const InputDecoration(labelText: 'Date of Birth'),
                format: DateFormat('MM-dd-yyyy'),
                // Validation
                validator: FormBuilderValidators.required(context,
                    errorText: 'DOB required'),
              ),
              
              // Password field
              FormBuilderTextField(
                name: 'password',
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                // Validation
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context,
                      errorText: 'Password required'),
                  FormBuilderValidators.minLength(context, 6,
                      errorText: 'Password must meet requirements'),
                ]),
              ),
              
              const SizedBox(height: 20),
              
              // Submit Button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                      // Optionally, navigate to Home Page.
                      Navigator.pushNamed(context, '/home');
                    }
                  },
                  child: const Text('Signup'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: const Center(
        child: Text('Signup successful! Welcome to the Home Page!'),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() => MyCustomFormState();
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
