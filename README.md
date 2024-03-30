
# Capstone Project

Our capstone project focuses on the Te Tuhi Disability Training Cafe, in which we build a platform for their cafe staff to use, particularly their trainees as these are people with intellectual impairments. 

## Contributors

- Saacha Moyo (Team Lead)
- Eisen Belleza (Backend Developer)
- Istefat Sawda (Fullstack Developer)
- Zainab Shehzad (Fullstack Developer)
- Natania Thomas (Project Manager)

# Backend Resources
## Document
[Backend Section Document](https://docs.google.com/document/d/1SDRM_Ymiu-dTaR5IqxHMonCC6Gumcb81q76EDuDEwJI/edit?usp=sharing)

## Videos
- [AWS Full Web App Portfolio Project Tutorial](https://youtu.be/zuKu0VFiwas?si=QnAoLocDemAZlc-r)
- [AWS DynamoDB Tutorial for Beginners](https://youtu.be/FQrN5aJWa_U?si=Y3kmW1Fro0TJwFDH)

# Frontend Resources
## Document

## Videos

## Design Ideas





# tetuhi
### Table of contents
- [System requirements](#system-requirements)
- [Figma design guidelines for better UI accuracy](#figma-design-guideline-for-better-accuracy)
- [Check the UI of the entire app](#app-navigations)
- [Application structure](#project-structure)
- [How to format your code?](#how-you-can-do-code-formatting)
- [How you can improve code readability?](#how-you-can-improve-the-readability-of-code)
- [Libraries and tools used](#libraries-and-tools-used)


### System requirements

Dart SDK Version 2.18.0 or greater.
Flutter SDK Version 3.3.0 or greater.

### Figma design guidelines for better UI accuracy

### Check the UI of the entire app

Check the UI of all the app screens from a single place by setting up the 'initialRoute'  to AppNavigation in the AppRoutes.dart file.

### Application structure
After successful build, your application structure should look like this:
                    
```
.
├── android                         - It contains files required to run the application on an Android platform.
├── assets                          - It contains all images and fonts of your application.
├── ios                             - It contains files required to run the application on an iOS platform.
├── lib                             - Most important folder in the application, used to write most of the Dart code..
    ├── main.dart                   - Starting point of the application
    ├── core
    │   ├── app_export.dart         - It contains commonly used file imports
    │   ├── constants               - It contains static constant class file
    │   └── utils                   - It contains common files and utilities of the application
    ├── presentation                - It contains widgets of the screens
    ├── routes                      - It contains all the routes of the application
    └── theme                       - It contains app theme and decoration classes
    └── widgets                     - It contains all custom widget classes
```