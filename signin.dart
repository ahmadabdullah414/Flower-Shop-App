import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower/Authentication/forgot.dart';
import 'package:flower/Authentication/signup.dart';
import 'package:flower/Listings/list.dart';
import 'package:flutter/material.dart';


class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _LoginState();
}

class _LoginState extends State<Signin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = false; // Track password visibility
  bool _isLoading = false; // Track loading state for login button
  bool _isGuestLoading = false; // Track loading state for guest login button
  double _opacity = 0.0; // Opacity for the animation

  @override
  void initState() {
    super.initState();
    // Start the animation after a short delay
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _opacity = 1.0; // Fade in
      });
    });
  }

  void _login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    setState(() {
      _isLoading = true; // Show loading indicator when login starts
    });

    try {
      // Attempt to sign in using Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // Navigate to home page if login is successful
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const ListingPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0); // Slide in from the right
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      );
    } catch (e) {
      // If sign in fails, show an error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid email or password')),
      );
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator after login process
      });
    }
  }

  void _guestLogin() async {
    setState(() {
      _isGuestLoading = true; // Show loading indicator when guest login starts
    });

    try {
      // Simulate a delay for the guest login process
      await Future.delayed(const Duration(seconds: 2));

      // Navigate to home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ListingPage()),
      );
    } finally {
      setState(() {
        _isGuestLoading =
            false; // Hide loading indicator after guest login process
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    dynamic screenWidth = MediaQuery.of(context).size.width;
    dynamic screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black87,
      resizeToAvoidBottomInset: false,
      body: AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        opacity: _opacity,
        child: Stack(
          children: [
            // Background Image
            Container(
              height: screenHeight,
              width: screenWidth,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Semi-transparent overlay to make content more visible
            Container(
              height: screenHeight,
              width: screenWidth,
              color: Colors.black
                  .withOpacity(0.2), // Semi-transparent black overlay
            ),

            // Scrollable content
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  Container(
                    width: 435,
                    height: 100,
                    color: Colors.black12,
                    child: const Center(
                      child: Text(
                        'Online Flowers Shop',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 30,
                          color: Colors.amber,
                          shadows: [
                            Shadow(
                              offset: Offset(4.0, 4.0),
                              blurRadius: 20.0,
                              color: Colors.black54,
                            ),
                            Shadow(
                              offset: Offset(-2.0, -2.0),
                              blurRadius: 3.0,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  // Login text
                  Container(
                    width: 100,
                    height: 60,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: const Center(
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: Colors.amber,
                          shadows: [
                            Shadow(
                              offset: Offset(2.0, 2.0),
                              blurRadius: 12.0,
                              color: Colors.black54,
                            ),
                            Shadow(
                              offset: Offset(-2.0, -2.0),
                              blurRadius: 3.0,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Email and password fields
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: SizedBox(
                      width: 400,
                      child: Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              filled: true, // Enable background color
                              fillColor: Colors.black54, // Background color
                              hintText: 'Enter Email',
                              hintStyle: const TextStyle(
                                color:
                                    Colors.amber, // Change the hint text color
                              ),
                              prefixIcon:
                                  const Icon(Icons.email, color: Colors.amber),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.white, // Border color
                                  width: 2.0, // Border thickness
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors
                                      .white, // Border color when not focused
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color:
                                      Colors.amber, // Border color when focused
                                  width: 3.0,
                                ),
                              ),
                            ),
                            controller: emailController,
                            style: const TextStyle(color: Colors.amber),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            decoration: InputDecoration(
                              filled: true, // Enable background color
                              fillColor: Colors.black54, // Background color
                              hintText: 'Enter Password',
                              hintStyle: const TextStyle(
                                color:
                                    Colors.amber, // Change the hint text color
                              ),
                              prefixIcon:
                                  const Icon(Icons.lock, color: Colors.amber),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.amber,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible =
                                        !_isPasswordVisible; // Toggle visibility
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.white, // Border color
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors
                                      .white, // Border color when not focused
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color:
                                      Colors.amber, // Border color when focused
                                  width: 3.0,
                                ),
                              ),
                            ),
                            controller: passwordController,
                            obscureText: !_isPasswordVisible,
                            style: const TextStyle(color: Colors.amber),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Forgot()));
                                },
                                child: const Text(
                                  'Forgot Password ?',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpPage()));
                                },
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Login button
                  Center(
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: _isLoading
                              ? null
                              : _login, // Disable button when loading
                          child: Container(
                            width: 140,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(width: 2, color: Colors.black),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: _isLoading
                                    ? const SizedBox(
                                        width:
                                            20, // Adjust the width of the CircularProgressIndicator
                                        height:
                                            20, // Adjust the height of the CircularProgressIndicator
                                        child: CircularProgressIndicator(
                                          color: Colors.black,
                                          strokeWidth:
                                              3.0, // You can also adjust the thickness
                                        ),
                                      )
                                    : const Text(
                                        'Login Now!',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18),
                                      ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 1),
                        const Text(
                          'OR',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 1),
                        TextButton(
                          onPressed: _isGuestLoading
                              ? null
                              : _guestLogin, // Disable button when loading
                          child: Container(
                            width: 170,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(width: 2, color: Colors.black)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: _isGuestLoading
                                    ? const SizedBox(
                                        width:
                                            20, // Adjust the width of the CircularProgressIndicator
                                        height:
                                            20, // Adjust the height of the CircularProgressIndicator
                                        child: CircularProgressIndicator(
                                          color: Colors.black,
                                          strokeWidth:
                                              3.0, // You can also adjust the thickness
                                        ),
                                      )
                                    : const Text(
                                        'Login as a Guest',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18),
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
