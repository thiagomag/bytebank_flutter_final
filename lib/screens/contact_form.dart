import 'package:flutter/material.dart';

import '../database/dao/contact_dao.dart';
import '../models/contact.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  static const String _novoContato = 'Novo Contato';
  static const String _nomeCompleto = 'Nome Completo';
  static const String _numeroConta = 'Numero Conta';
  static const String _criar = 'Criar';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_novoContato),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: _nomeCompleto,
              ),
              style: const TextStyle(
                fontSize: 24.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _accountNumberController,
                decoration: const InputDecoration(
                  labelText: _numeroConta,
                ),
                style: const TextStyle(
                  fontSize: 24.0,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    final String? name = _nameController.text.toString();
                    final int? accountNumber =
                        int.tryParse(_accountNumberController.text.toString());
                    final Contact newContact = Contact(0, name!, accountNumber!);
                    _dao.save(newContact).then((id) => Navigator.pop(context));
                  },
                  child: const Text(_criar),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
