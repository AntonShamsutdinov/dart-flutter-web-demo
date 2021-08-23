# Dart/Flutter Web Demo

A demo project to demonstrate web-development experience.

## Requirements

The goal of this task is to:
- Create a single page application
- Implement search and filtering capabilities
- Implement a details view
- Utilize dataverse as a data storage (you can use WebAPI)
- You should figure out how to load sample data into you instance (google it)

### Functional Details

- Search by account name or account number 
- Filtering by StateCode and StateOrProvince

### Non-Functional Requirements

- Implement using React or Dart/Flutter
- Implement preloader for search and filtering
- Unit Tests
- UI components tests
- Docker container build scripts

## Implementation

### Functional

Search by account name or account number is implemented. Filtering is TBD.

### Non-Functional

This demo project is implemented in Dart/Flutter.

Accounts are loading in an async process after Access Token is provided.

account-service-test.dart and account-test.dart files contains unit tests for project. It does not fully cover code.
It just displays the ability of writing unit tests.

screen-tests.dart file contain widget tests (UI components tests). It does not fully cover UI components and just
displays the ability of writing widget tests.