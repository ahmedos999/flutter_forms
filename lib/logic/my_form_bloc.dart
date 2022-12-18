import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_forms/models/phone.dart';
import 'package:formz/formz.dart';

import '../models/email.dart';
import '../models/password.dart';

part 'my_form_event.dart';
part 'my_form_state.dart';

class MyFormBloc extends Bloc<MyFormEvent, MyFormState> {
  MyFormBloc() : super(const MyFormState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<PhoneChanged>(_onPhoneChanged);
    on<EmailUnfocused>(_onEmailUnfocused);
    on<PasswordUnfocused>(_onPasswordUnfocused);
    on<PhoneUnfocused>(_onPhoneUnfocused);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onEmailChanged(EmailChanged event, Emitter<MyFormState> emit) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email.valid ? email : Email.pure(event.email),
        status: Formz.validate([email, state.phone, state.password]),
      ),
    );
  }

  void _onPhoneChanged(PhoneChanged event, Emitter<MyFormState> emit) {
    final phone = Phone.dirty(event.phone);
    emit(state.copyWith(
        phone: phone.valid ? phone : Phone.pure(event.phone),
        status: Formz.validate([state.email, phone, state.password])));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<MyFormState> emit) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password.valid ? password : Password.pure(event.password),
        status: Formz.validate([state.email, state.phone, password]),
      ),
    );
  }

  void _onEmailUnfocused(EmailUnfocused event, Emitter<MyFormState> emit) {
    final email = Email.dirty(state.email.value);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([email, state.phone, state.password]),
      ),
    );
  }

  void _onPhoneUnfocused(PhoneUnfocused event, Emitter<MyFormState> emit) {
    final phone = Phone.dirty(state.phone.value);
    emit(state.copyWith(
        phone: phone,
        status: Formz.validate([state.email, phone, state.password])));
  }

  void _onPasswordUnfocused(
    PasswordUnfocused event,
    Emitter<MyFormState> emit,
  ) {
    final password = Password.dirty(state.password.value);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([state.email, state.phone, password]),
      ),
    );
  }

  Future<void> _onFormSubmitted(
    FormSubmitted event,
    Emitter<MyFormState> emit,
  ) async {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final phone = Phone.dirty(state.phone.value);
    emit(
      state.copyWith(
        email: email,
        phone: phone,
        password: password,
        status: Formz.validate([email, phone, password]),
      ),
    );
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    }
  }
}
