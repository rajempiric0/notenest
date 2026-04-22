import 'package:NoteNest/features/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/svg.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();
  late var _isObscured = true;
  late var _isObscuredText = true;

  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Padding(
                padding: const EdgeInsets.only(top: 23),
                child: SvgPicture.asset(
                  'assets/logo/logo_auth.svg',
                  width: 100,
                  height: 100,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                "Create Your Account",
                style: GoogleFonts.beVietnamPro(
                  color: Color(0xFF262626),
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "Start organizing your tasks and boost your productivity today.",
                textAlign: TextAlign.center,
                style: GoogleFonts.beVietnamPro(
                  color: Color(0xFF6F6F73),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 24),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: firstNameController,
                        hint: "Jack",
                        label: "First Name",
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildTextField(
                        controller: lastNameController,
                        hint: "Rob",
                        label: "Last Name",
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Text(
                      //Email
                      "Email Address",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 4),

              Container(
                //Email Container
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextField(
                  controller: emailController,
                  decoration:  InputDecoration(
                    icon: SvgPicture.asset('assets/auth/sms.svg',width: 22,height: 22,fit: BoxFit.cover,),
                    hintText: "e.g. jackrob187@gmail.com",
                    border: InputBorder.none,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Password Label
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Text(
                      //Email
                      "Password",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 4),

              Container(
                //Email Container
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextField(
                  obscureText: _isObscuredText,

                  controller: passwordController,

                  decoration: InputDecoration(
                    contentPadding: EdgeInsetsGeometry.symmetric(
                      vertical: 15,
                      horizontal: 5,
                    ),
                    icon: SvgPicture.asset('assets/auth/lock.svg',width: 22,height: 22,fit: BoxFit.cover,),
                    hintText: "* * * * * * * * ",

                    hintStyle: GoogleFonts.beVietnamPro(
                      fontSize: 14,
                      color: Color(0xFF7D7D80),
                    ),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isObscuredText = !_isObscuredText;
                        });
                      },
                      icon: _isObscuredText == true
                          ? Icon(Icons.remove_red_eye_outlined)
                          : Icon(Icons.visibility_off_outlined),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Text(
                      "Confirm Password",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 4),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextField(
                  obscureText: _isObscured,

                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsetsGeometry.symmetric(
                      vertical: 15,
                      horizontal: 5,
                    ),
                    icon: SvgPicture.asset('assets/auth/lock.svg',width: 22,height: 22,fit: BoxFit.cover,),
                    hintText: "* * * * * * * * ",

                    hintStyle: GoogleFonts.beVietnamPro(
                      fontSize: 14,
                      color: Color(0xFF7D7D80),
                    ),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                      icon: _isObscured == true
                          ? Icon(Icons.remove_red_eye_outlined)
                          : Icon(Icons.visibility_off_outlined),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  children: [
                    Checkbox(
                      value: _isChecked,
                      onChanged: (bool? newValue) {
                        setState(() {
                          _isChecked = newValue!; // Updates the state on tap
                        });
                      },
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: "By continuing you agree to our ",
                          style: const TextStyle(color: Colors.grey,fontSize: 14),
                          children: [
                            TextSpan(
                              text: "Terms",
                              style: TextStyle(decoration:TextDecoration.underline ,
                                color: Colors.deepPurple.shade400,
                                fontWeight: FontWeight.w500,
                                fontSize: 14
                              ),
                            ),
                            const TextSpan(text: "\n&  "),
                            TextSpan(
                              text: "Policy",
                              style: TextStyle(decoration: TextDecoration.underline,
                                color: Colors.deepPurple.shade400,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF794098),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Sign up",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1.5,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.transparent, Color(0xFFD2D2D2)],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Text(
                    "Or continue with",
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Container(
                      height: 1.5,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.grey.shade400, Color(0xFFD2D2D2)],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: _socialButton(
                      SvgPicture.asset(
                        'assets/auth/google.svg',
                        width: 24,
                        height: 24,
                        fit: BoxFit.contain,
                      ),
                      "Google",
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _socialButton(const Icon(Icons.apple), "Apple"),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// FOOTER
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don’t have an account? "),
                  InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    ),
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.deepPurple.shade400,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required String label,
    IconData? icon,
    bool isPassword = false,
    IconData? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.beVietnamPro(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF262626),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: TextField(
            controller: controller,
            obscureText: isPassword,
            decoration: InputDecoration(
              prefixIcon: icon != null ? Icon(icon) : null,
              suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
              hintText: hint,
              hintStyle: GoogleFonts.beVietnamPro(fontSize: 14),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _socialButton(Widget icon, String text) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [icon, const SizedBox(width: 8), Text(text)],
      ),
    );
  }
}
