import 'package:flower/Authentication/signin.dart';
import 'package:flower/Listings/list.dart';
import 'package:flutter/material.dart';

class Rating extends StatefulWidget {
  const Rating({super.key});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<Rating> {
  final TextEditingController _commentController = TextEditingController();
  int _rating = 0; // Star rating (0 to 5)
  double _opacity = 0.0; // Opacity for the animation
  final List<Map<String, dynamic>> _reviews = [];

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

  // Function to show error
  void _showErrorSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Function to handle submitting the review
  void _submitReview() {
    final comment = _commentController.text;
    if (comment.isEmpty || _rating == 0) {
      _showErrorSnackBar(context, 'Please enter a comment and give a rating');
      return;
    }

    // Add the review to the list
    setState(() {
      _reviews.add({'comment': comment, 'rating': _rating});
    });

    // Reset the form after submission
    _commentController.clear();
    setState(() {
      _rating = 0;
    });

    // Show a confirmation message
    const snackBar = SnackBar(content: Text('Review submitted successfully!'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.of(context).pop(); // Close the dialog
  }

  // Function to build star rating widget
  Widget _buildStarRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < _rating ? Icons.star : Icons.star_border,
            color: Colors.amber,
          ),
          onPressed: () {
            setState(() {
              _rating = index + 1; // Rating is 1-based, so add 1
            });
          },
        );
      }),
    );
  }

  // Function to display reviews
  Widget _buildReviewList() {
    return _reviews.isEmpty
        ? const Center(
            child:
                Text('No reviews yet', style: TextStyle(color: Colors.white)))
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _reviews.length,
            itemBuilder: (context, index) {
              final review = _reviews[index];
              return Card(
                color: Colors.black54,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Row(
                    children: List.generate(
                      5,
                      (starIndex) => Icon(
                        starIndex < review['rating']
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                        size: 20,
                      ),
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(review['comment'],
                        style: const TextStyle(color: Colors.white)),
                  ),
                ),
              );
            },
          );
  }

  void _showRatingDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black54,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Centered Title
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      'Rate Our App',
                      style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // Star Rating Widget
                  _buildStarRating(),
                  // Comment Field
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: TextField(
                      controller: _commentController,
                      maxLines: 4,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Write your review here...',
                        hintStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.white24,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  // Buttons Aligned Horizontally at the Bottom
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Close',
                          style: TextStyle(color: Colors.amber),
                        ),
                      ),
                      const SizedBox(width: 20), // Space between buttons
                      TextButton(
                        onPressed: _submitReview,
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.amber),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30, top: 120),
        child: Align(
          alignment: Alignment.topLeft,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const ListingPage()));
            },
            backgroundColor: Colors.transparent,
            child: const Icon(Icons.arrow_back, color: Colors.amber),
          ),
        ),
      ),
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Row(
          children: [
            PopupMenuButton<String>(
              color: Colors.black45,
              icon: const Icon(Icons.menu, size: 30, color: Colors.amber),
              position: PopupMenuPosition.under,
              offset: const Offset(0, 0),
              itemBuilder: (context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'home',
                  child: Text('Home',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.amber)),
                ),
                const PopupMenuItem<String>(
                  value: 'rating',
                  child: Text('Ratings',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white)),
                ),
                const PopupMenuItem<String>(
                  value: 'log out',
                  child: Text('Log Out',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.amber)),
                ),
              ],
              onSelected: (value) {
                if (value == 'home') {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ListingPage()));
                } else if (value == 'rating') {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Rating()));
                } else if (value == 'log out') {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Signin()));
                }
              },
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        opacity: _opacity,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _showRatingDialog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                  ),
                  child: const Text(
                    'Rate Our App',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                _buildReviewList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
