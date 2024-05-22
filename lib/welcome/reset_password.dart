import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

class PasswordResetPage extends StatefulWidget {
  @override
  _PasswordResetPageState createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _verificationCodeController =
      TextEditingController();

  bool _isCodeSent = false;
  String _errorMessage = '';
  bool _hasMinLength = false;
  bool _hasUppercase = false;
  bool _hasNumber = false;
  bool _hasSpecialChar = false;
  bool _passwordsMatch = false;
  bool _isNewPasswordVisible = false; // For toggling new password visibility
  bool _isConfirmPasswordVisible =
      false; // For toggling confirm password visibility

  void _validatePassword(String password) {
    setState(() {
      _hasMinLength = password.length >= 8;
      _hasUppercase = password.contains(RegExp(r'[A-Z]'));
      _hasNumber = password.contains(RegExp(r'[0-9]'));
      _hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      _passwordsMatch = password == _confirmPasswordController.text;
    });
  }

  void _validateConfirmPassword(String confirmPassword) {
    setState(() {
      _passwordsMatch = confirmPassword == _newPasswordController.text;
    });
  }

  Future<void> _sendVerificationCode() async {
    try {
      await Amplify.Auth.resetPassword(
        username: _usernameController.text.trim(),
      );
      setState(() {
        _isCodeSent = true;
        _errorMessage = ''; // Clear any previous error messages
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
    if (!_passwordsMatch) {
      setState(() {
        _errorMessage = 'Passwords do not match';
      });
      return;
    }
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
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            if (_isCodeSent) ...[
              TextField(
                controller: _verificationCodeController,
                decoration: InputDecoration(labelText: 'Verification Code'),
              ),
              TextField(
                controller: _newPasswordController,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isNewPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isNewPasswordVisible = !_isNewPasswordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !_isNewPasswordVisible,
                onChanged: _validatePassword,
              ),
              TextField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !_isConfirmPasswordVisible,
                onChanged: _validateConfirmPassword,
              ),
              _buildPasswordValidationIndicators(),
            ],
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isCodeSent ? _resetPassword : _sendVerificationCode,
              child: Text(
                  _isCodeSent ? 'Reset Password' : 'Send Verification Code'),
            ),
            if (_errorMessage.isNotEmpty) ...[
              SizedBox(height: 20),
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordValidationIndicators() {
    return Column(
      children: [
        _buildValidationIndicator('At least 8 characters', _hasMinLength),
        _buildValidationIndicator(
            'Contains an uppercase letter', _hasUppercase),
        _buildValidationIndicator('Contains a number', _hasNumber),
        _buildValidationIndicator(
            'Contains a special character', _hasSpecialChar),
        _buildValidationIndicator('Passwords match', _passwordsMatch),
      ],
    );
  }

  Widget _buildValidationIndicator(String text, bool isValid) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check : Icons.close,
          color: isValid ? Colors.green : Colors.red,
        ),
        SizedBox(width: 8),
        Text(text),
      ],
    );
  }
}
