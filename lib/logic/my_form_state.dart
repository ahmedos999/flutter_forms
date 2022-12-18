part of 'my_form_bloc.dart';

class MyFormState extends Equatable {
  const MyFormState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.phone = const Phone.pure(),
    this.status = FormzStatus.pure,
  });

  final Email email;
  final Password password;
  final Phone phone;
  final FormzStatus status;

  MyFormState copyWith({
    Email? email,
    Password? password,
    Phone? phone,
    FormzStatus? status,
  }) {
    return MyFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [email, password, phone, status];
}
