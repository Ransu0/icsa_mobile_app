import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    // --- Define our colors for easy reuse ---
    final Color cardBackgroundColor = Color(0xFF2A3A4D); // Dark blue-grey
    final Color statusColor = Color(0xFF29B6F6); // Light blue
    final Color iconAndTitleColor = Colors.white;

    return Container(
      // Constrain the width of the card
      width: 170,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        // The background color of the card
        color: cardBackgroundColor,

        // This creates the rounded corners
        borderRadius: BorderRadius.circular(12.0),

        // This adds the subtle drop shadow
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: Offset(0, 4), // Shadow position
          ),
        ],
      ),
      child: Column(
        // Align all children to the left side
        crossAxisAlignment: CrossAxisAlignment.start,

        // Make the Column wrap its content's height
        mainAxisSize: MainAxisSize.min,
        children: [
          // --- 1. The Icon ---
          Icon(
            Icons
                .assignment, // This icon looks very similar to the one in the image
            color: iconAndTitleColor,
            size: 32.0, // Set the icon size
          ),

          // --- 2. Spacer ---
          SizedBox(height: 16.0), // Space between icon and text

          // --- 3. The "Clearance" Text ---
          Text(
            'Clearance',
            style: TextStyle(
              color: iconAndTitleColor,
              fontWeight: FontWeight.bold, // Makes the text bold
              fontSize: 22.0, // Set the font size
            ),
          ),

          // --- 4. Spacer ---
          SizedBox(height: 4.0), // Smaller space between the two text lines

          // --- 5. The "Cleared" Text ---
          Text(
            'Cleared',
            style: TextStyle(
              color: statusColor, // Use the light blue color
              fontSize: 16.0,
              fontWeight: FontWeight.w500, // A medium weight
            ),
          ),
        ],
      ),
    );
  }
}
