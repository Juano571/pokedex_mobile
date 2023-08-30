import 'package:flutter/material.dart';
import 'package:pokedex_mobile/providers/pokemon_provider.dart';
import 'package:provider/provider.dart';

class InputCommentWiget extends StatefulWidget {
  final int id;
  const InputCommentWiget({super.key, required this.id});

  @override
  State<InputCommentWiget> createState() => _InputCommentWigetState();
}

class _InputCommentWigetState extends State<InputCommentWiget> {
  final _formKey = GlobalKey<FormState>();
  final _myController = TextEditingController();
  late FocusNode _textFocus;

  _printText() {
    print('El texto del input es ${_myController.text}');
  }

  @override
  void initState() {
    _myController.addListener(_printText);
    _textFocus = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    icon: Icon(Icons.comment),
                    //suffixIcon: Icon(Icons.close),
                    hintText: 'Ingrese su comentario',
                    labelText: 'Comentario'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El comentario es requerido';
                  }
                  return null;
                },
                controller: _myController,
                focusNode: _textFocus,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        /*action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {},
                        ),*/
                        content: Text('Agregando Comentario')));
                    print('El valor del comentario es: ${_myController.text}');
                    Provider.of<PokemonProvider>(context, listen: false)
                        .addCommentToPokemonDoc(widget.id, _myController.text);
                    _myController.text = '';
                  }
                },
                child: const Text('Submit')),
            OutlinedButton(
                onPressed: () {
                  _textFocus.requestFocus();
                },
                child: Text('Set Focus'))
          ],
        ));
  }
}
