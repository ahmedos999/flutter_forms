import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_forms/logic/my_form_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

Widget textfield(
    String label,
    String hint,
    bool hidden,
    TextInputType type,
    IconData icon,
    FocusNode focusNode,
    BuildContext context,
    bool messageStatus) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: TextFormField(
            onChanged: ((value) {
              context.read<MyFormBloc>().add(EmailChanged(email: value));
            }),
            focusNode: focusNode,
            obscureText: hidden,
            keyboardType: type,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              errorText:
                  messageStatus ? 'Please ensure the email is valid' : null,
              filled: true,
              fillColor: Colors.white,
              hintStyle: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.black45,
              ),
              hintText: hint,
              focusColor: Colors.grey,
              suffixIcon: Icon(icon, size: 25, color: const Color(0xff606470)),
              enabledBorder: UnderlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.white54,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xff93DEFF)),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.hint,
      required this.hidden,
      required this.focusNode,
      required this.icon,
      required this.label,
      required this.type});

  final String label;
  final String hint;
  final bool hidden;
  final TextInputType type;
  final IconData icon;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyFormBloc, MyFormState>(builder: (context, state) {
      print(
          'the email one : ${state.email.invalid} + ${state.password.invalid}');
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: TextFormField(
                initialValue: state.email.value,
                onChanged: ((value) {
                  print(
                      'the email one 2: ${state.email.invalid} + ${state.password.invalid}');
                  context.read<MyFormBloc>().add(EmailChanged(email: value));
                }),
                focusNode: focusNode,
                obscureText: hidden,
                keyboardType: type,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  errorText: state.email.invalid
                      ? 'Please ensure the email is valid'
                      : null,
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.black45,
                  ),
                  hintText: hint,
                  focusColor: Colors.grey,
                  suffixIcon:
                      Icon(icon, size: 25, color: const Color(0xff606470)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white54,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xff93DEFF)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class CustomPassField extends StatefulWidget {
  const CustomPassField(
      {super.key,
      required this.hint,
      required this.hidden,
      required this.focusNode,
      required this.icon,
      required this.label,
      required this.type});

  final String label;
  final String hint;
  final bool hidden;
  final TextInputType type;
  final IconData icon;
  final FocusNode focusNode;

  @override
  State<CustomPassField> createState() => _CustomPassFieldState();
}

class _CustomPassFieldState extends State<CustomPassField> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyFormBloc, MyFormState>(builder: (context, state) {
      print('${state.email.invalid} + ${state.password.invalid}');
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.label,
              style: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: TextFormField(
                initialValue: state.password.value,
                onChanged: ((value) {
                  context
                      .read<MyFormBloc>()
                      .add(PasswordChanged(password: value));
                }),
                focusNode: widget.focusNode,
                obscureText: widget.hidden,
                keyboardType: widget.type,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  errorText: state.password.invalid
                      ? 'Please ensure the password is 8 lentgh long and have lettet and numbers'
                      : null,
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.black45,
                  ),
                  hintText: widget.hint,
                  focusColor: Colors.grey,
                  suffixIcon: Icon(widget.icon,
                      size: 25, color: const Color(0xff606470)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white54,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xff93DEFF)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
