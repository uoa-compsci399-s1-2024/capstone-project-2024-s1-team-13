import 'dart:async';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

class PasswordResetPage extends StatefulWidget {
  @override
  _PasswordResetPageState createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _verificationCodeController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  bool _isCodeSent = false;
  String _errorMessage = ' ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (!_isCodeSent) ...[
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _sendVerificationCode,
                child: Text('Send Verification Code'),
              ),
            ] else ...[
              TextFormField(
                controller: _verificationCodeController,
                decoration: InputDecoration(
                  labelText: 'Verification Code',
                ),
              ),
              TextFormField(
                controller: _newPasswordController,
                decoration: InputDecoration(
                  labelText: 'New Password',
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _resetPassword,
                child: Text('Reset Password'),
              ),
            ],
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendVerificationCode() async {
    try {
      await Amplify.Auth.resetPassword(
        username: _usernameController.text.trim(),
      );
      setState(() {
        _isCodeSent = true;
      });
    } on AuthException catch (e) {
      setState(() {
        _errorMessage = 'Error sending verification code: ${e.message}';
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'An unexpected error occurred';
      });
    }
  }

  Future<void> _resetPassword() async {
    try {
      await Amplify.Auth.confirmResetPassword(
        username: _usernameController.text.trim(),
        newPassword: _newPasswordController.text.trim(),
        confirmationCode: _verificationCodeController.text.trim(),
      );
      Navigator.pop(context);
    } on AuthException catch (e) {
      setState(() {
        _errorMessage = 'Error resetting password: ${e.message}';
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'An unexpected error occurred';
      });
    }
  }
}
