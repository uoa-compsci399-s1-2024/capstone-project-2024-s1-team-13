import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/widgets.dart';

class PasswordResetPage extends StatefulWidget {
  @override
  _PasswordResetPageState createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  //GLOBAL VARIABLES
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

  //BACKEND FUNCTIONS
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

  Widget _usernameInput() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Username",
            style: TextStyle(
              fontFamily: "Lexend Exa",
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextField(
              controller: _usernameController,
              style: const TextStyle(
                  fontFamily: "Lexend Exa",
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 25.0),
                filled: true,
                fillColor: Colors.grey[300],
                hintText: "Enter username",
                hintStyle: TextStyle(
                    fontFamily: "Lexend Exa",
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[400]),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none),
              )),
        ],
      );

  Widget _verificationCodeInput() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Verification Code",
            style: TextStyle(
              fontFamily: "Lexend Exa",
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextField(
              controller: _verificationCodeController,
              style: const TextStyle(
                  fontFamily: "Lexend Exa",
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 25.0),
                filled: true,
                fillColor: Colors.grey[300],
                hintText: "Enter verification code",
                hintStyle: TextStyle(
                    fontFamily: "Lexend Exa",
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[400]),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none),
              )),
        ],
      );

  Widget _newPasswordCodeInput() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "New Password",
            style: TextStyle(
              fontFamily: "Lexend Exa",
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextField(
            controller: _newPasswordController,
            style: const TextStyle(
                fontFamily: "Lexend Exa",
                fontSize: 20,
                fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
              suffixIcon: IconButton(
                icon: Icon(
                    _isNewPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    size: 30),
                onPressed: () {
                  setState(() {
                    _isNewPasswordVisible = !_isNewPasswordVisible;
                  });
                },
              ),
              filled: true,
              fillColor: Colors.grey[300],
              hintText: "Enter new password",
              hintStyle: TextStyle(
                  fontFamily: "Lexend Exa",
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[400]),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none),
            ),
            obscureText: !_isNewPasswordVisible,
            onChanged: _validatePassword,
          ),
        ],
      );

  Widget _confirmPasswordCodeInput() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Confirm Password",
            style: TextStyle(
              fontFamily: "Lexend Exa",
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextField(
            controller: _confirmPasswordController,
            style: const TextStyle(
                fontFamily: "Lexend Exa",
                fontSize: 20,
                fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
              suffixIcon: IconButton(
                icon: Icon(
                    _isConfirmPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    size: 30),
                onPressed: () {
                  setState(() {
                    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                  });
                },
              ),
              filled: true,
              fillColor: Colors.grey[300],
              hintText: "Enter password again",
              hintStyle: TextStyle(
                  fontFamily: "Lexend Exa",
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[400]),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none),
            ),
            obscureText: !_isConfirmPasswordVisible,
            onChanged: _validatePassword,
          ),
        ],
      );

  //FRONTEND
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Reset Password'),
          leading: IconButton(
              iconSize: 40,
              icon: const Icon(Icons.arrow_back_ios),
              padding:
                  const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
              onPressed: () {
                Navigator.pop(context);
              })),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
                child: _usernameInput(),
              ),
              SizedBox(height: 15),
              if (_isCodeSent) ...[
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: _verificationCodeInput(),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: _newPasswordCodeInput(),
                ),
                SizedBox(height: 15),
                Padding(
                    padding: EdgeInsets.only(left: 50, right: 50),
                    child: _confirmPasswordCodeInput()),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: _buildPasswordValidationIndicators(),
                ),
              ],
              SizedBox(height: 25),
              ElevatedButton(
                  onPressed:
                      _isCodeSent ? _resetPassword : _sendVerificationCode,
                  child: Text(_isCodeSent
                      ? 'Reset Password'
                      : 'Send Verification Code'),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(500, 80),
                      foregroundColor: Colors.white,
                      textStyle: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Lexend Exa',
                        fontWeight: FontWeight.w500,
                      ),
                      backgroundColor: Colors.pink[900],
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)))),
              if (_errorMessage.isNotEmpty) ...[
                SizedBox(height: 10),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 50, right: 50, top: 10),
                    child: Text(
                      _errorMessage,
                      style: TextStyle(
                          fontFamily: 'Lexend Exa',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.red),
                    ),
                  ),
                ),
              ],
            ],
          ),
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
          size: 30,
        ),
        SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
              fontFamily: 'Lexend Exa',
              fontSize: 20,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
