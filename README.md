# 
# Flutter Challenge App

## Overview
This is a Flutter application fetch Random number from API, each 10 secs and check if it prime or not.

## Setup Instructions

### Prerequisites
Before you begin, make sure you have the following installed:
- [Flutter](https://docs.flutter.dev/get-started/install) SDK
- Dart
- Android Studio or Xcode for emulators
- Git (for cloning the repository)

### Steps to Run the Project

1. **Clone the Repository**
   ```bash
   
   git git@github.com:qaysdwekat/flutter_challenge.git 

   cd flutter_challenge
   ```
2. **Run the Application**

    ```bash
    flutter run
    ```

   * Note: The app works on iOS, Android, and Web. 
    However, on Web, due to CORS restrictions, the API will always throw an exception unless the server explicitly allows cross-origin requests.


3. **Generate Mocks Files**
 Use the following command to generate the necessary Mocks files:

    ```bash
    dart run build_runner build
    ```


### Running Tests

- Unit & Widget Tests Run the following command to execute the tests:
   
    ```bash
    flutter test
    ```

    To generate a code coverage report:

    ```bash
    flutter test --coverage
    ```

    To view the HTML coverage report:

    ```bash
    genhtml coverage/lcov.info -o coverage/html
    open coverage/html/index.html  # For macOS  
    # or  
    xdg-open coverage/html/index.html  # For Linux  
    ```
    ⚠️ Make sure you have lcov installed. On macOS you can use:
`brew install lcov`

- Integration Test Run the following command to execute the tests:

    ```bash
    flutter test integration_test
    ```
