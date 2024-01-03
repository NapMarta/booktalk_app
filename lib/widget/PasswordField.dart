import 'package:booktalk_app/utils.dart';
import 'package:flutter/material.dart';
    
class PasswordField extends StatefulWidget {
  const PasswordField({
    this.restorationId,
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.focusNode,
    this.textInputAction,
    this.height,
    this.width,
    this.text
  });

  final String? restorationId;
  final Key? fieldKey;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final double? width, height;
  final String? text;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> with RestorationMixin {
  final RestorableBool _obscureText = RestorableBool(true);

  @override
  String? get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_obscureText, 'obscure_text');
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
       decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _obscureText.value = !_obscureText.value;
            });
          },
          hoverColor: Colors.transparent,
          icon: Icon(
            _obscureText.value ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
        ),

        fillColor: const Color.fromARGB(123, 255, 255, 255),
        // focusColor: Color(0xFF0097b2),
        labelText: widget.text, 
        labelStyle: TextStyle(fontSize: size(widget.width, widget.height, 16),
                              color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1.5,
          )
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1.5,
          ),
        ),
        filled: true,
        prefixIcon: Icon(Icons.lock, color: Colors.grey,),
        /* hintText: localizations.demoTextFieldYourEmailAddress,
        labelText: localizations.demoTextFieldEmail, */
      ),

      key: widget.fieldKey,
      restorationId: widget.restorationId,
      obscureText: _obscureText.value,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
    );
  }
}