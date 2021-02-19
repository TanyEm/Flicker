# Flickr

## Table of Contents

- [Screenshots](#screenshots)
- [Description](#description)
- [Implementation notes](#implementation-notes)
- [Things to improve](#things-to-improve)
- [Xcode Project Setup](#xcode-project-setup)

## Screenshots

<img src="https://github.com/TanyEm/Flicker/blob/main/screenshots/1.png" height="400"> <img src="https://github.com/TanyEm/Flicker/blob/main/screenshots/2.png" height="400"> <img src="https://github.com/TanyEm/Flicker/blob/main/screenshots/3.png" height="400"> 

## Description

The app allows users to search what they want using Flickr search API. 

### Implementation notes

There useed MVVM architecture, without hird party libraries. 
A user journey is: 
- As a user, I can search images using the search bar
- As a user, I can scroll photo collection
- If a phone has no internet connection, as a user, I will know it from the app
- As a user, I can search only relevant responses with 3 or more char

### Things to improve
- Make scrolling smoother
- Add pagination
- Add UI tests
- Make requests and present result when a user typs using Combine/RxSwift

## Xcode Project Setup

### Requirements

> A code signing key from Apple is required to deploy apps to a device. Without a developer key, the app can only be installed on the iPhone Simulator.

- Xcode  
- iOS 14 SDK
