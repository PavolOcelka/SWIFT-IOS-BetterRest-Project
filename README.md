# BetterRest IOS App

BetterRest is an iOS application built with SwiftUI that helps users calculate the optimal time to go to bed based on their desired sleep duration, daily coffee intake, and chosen wake-up time. The app leverages CoreML for precise sleep time predictions.

![App design](Screenshot%202025-01-16%20at%2015.39.20.png)

## **Features**
- Calculates the best bedtime based on user inputs.
- Provides a modern and intuitive interface using SwiftUI.
- Utilizes a machine learning model for accurate sleep predictions.
- Displays results in a user-friendly alert system.

## **How It Works**
1. **User Inputs:**
   - Select the desired wake-up time.
   - Set the amount of sleep you need (in hours).
   - Specify the number of cups of coffee consumed daily.

2. **Machine Learning Prediction:**
   - A CoreML model processes the inputs to calculate the optimal time for the user to go to bed.
   - The calculation takes into account the wake-up time, sleep duration, and coffee intake.

3. **Result Display:**
   - The app shows the calculated bedtime in a clear alert message, helping users plan their sleep better.

## **Technologies Used**
- **SwiftUI:** To build a sleek and modern user interface.
- **CoreML:** For integrating a pre-trained machine learning model that calculates sleep times.
- **State Management:** Leveraging `@State` in SwiftUI to manage user inputs and dynamic values.
- **NavigationStack:** For organizing and navigating between screens in the app.
- **ZStack:** To handle layered views, such as background colors and content.

![App design calculate](Screenshot%202025-01-16%20at%2015.39.32.png)

## **Inspiration**
This project was inspired by the ["Hacking with Swift"](https://www.hackingwithswift.com/) course by Paul Hudson.


