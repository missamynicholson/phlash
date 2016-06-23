# Phlash
![icon](http://i.imgur.com/XCR468v.png) ![main](http://i.imgur.com/4AyMZ4o.png) ![phlash](http://i.imgur.com/3P3he6l.png)

Phlash is a social network mobile app that allows users to unleash their creativity, taking random pictures (Phlashes), and sharing them with a list of "Phollowers".

## Authors

Phlash is the idea of a group of [Makers](http://www.makersacademy.com/) as its final project.  The Queen and Princes of Phlash are:

 * [Chris Coates](https://github.com/chriselevate)
 * [Sergio Enrech Trillo](https://github.com/tigretoncio)
 * [Ollie Haydon-Mulligan](https://github.com/ollieh-m)
 * [Amy Nicholson](https://github.com/missamynicholson)

## Usage
 
 The code is available in this repo, however the keys to connect to the database have been removed for security reasons.  We are registering the App in the App Store and will share the link when it is available.
 
## Technologies
 
Phlash has been developed for Apple devices, (IoS 9.0+), using XCode 7.3.1 and Swift 2.2. The backend service is provided by Parse and uses CloudCode, implemented in JavaScript, to secure user data and exchanges.  
 
The app has been also tested on IoS device as old as 7.0, although some compatibility issues have been experienced when retrieving pictures.  For best user experience IoS 9.0 is recommended.

## Challenges

This is a special team.  Not having enough with being challenged during 4 months coding like crazy in Ruby and Javascript, the PHLASH team decided they wanted to know how to develop a "Phlashy app" to show how much they could learn in very little time, (exactly 12 days), and take pics of [Dougal the Poodle](http://i.imgur.com/0pCDeFB.png?1), [Mabel](http://i.imgur.com/ZI8mXE7.jpg), the notorious [Sergio's neighbour cat](http://i.imgur.com/e6TL1Sr.png), or even [the mother duck-er](http://i.imgur.com/aTSMhz9.png)
 
None of the team knew about Swift before the start of the project, although Amy was a bit familiar with Xcode.  To make matters even more interesting, some of the members hadn't used a Mac in their lives before this project! (Sergio, we know who you are!)
 
We took a day to evaluate different mobile technos, and we decided to go for Swift.  Then, the challenge was to learn enough Swift and relevant tools (XCode and Parse) to get our app, and do it fast. 

Another challenge was to decide features we wanted for the app, and oversee the deployment using Agile practices.  We heavily relied on [Github](https://github.com) and [Waffle](https://waffle.io) to project manage the app development. 
 
Also using a TDD philosophy was challenging as we needed to understand the programming language and its test framework in order to create relevant tests driving the app development, for that we spend another 2 days making a "spike"

## User Stories
```
As a phlasher
So that I can use the app
I want to be able to signup
```
```
As a phlasher
So that I can user the app again and again
I want to be able to login
```
```
As a phlasher
So that no one can phlash on my behalf
I want to be able to logout
```
```
As a phlasher
So that I can phlash my followers
I want to take a photo
```
```
As a friendly phlashee
So that I can view someone's phlashes
I want to be able to phollow them
```
```
As a phlashee
So that I can see a phlash from someone I'm phollowing
I want to be able to view their photo
```
```
As a phlasher
so that I can know who is phollowing me
I want to get a notification when somenone starts phollowing me
```
```
As a phlasher
so that I can know when I get phlashes to watch
I want to get a notification when somenone I am phollowing phlashes
```
```
As a phlasher
So that I can protect my modesty
I want to limit how long my phollowers see my phlash
```
```
As a phlashee
So that I can see my phollowers’ phlashes
I want to get a notification when someone I’m phollowing phlashes
```
```
As a unfriendly phlashee
So that I can view less phlashes
I want to be able to unphollow a phlasher
```
```
As a forgetful phlasher
So that I can re-enter the app
I want to be able reset my password
```
```
As a phlasher
So that I can communicate fully
I want to add a caption to my phlashes
```
```
as a user
so that I can be in the know
I want to know if there are pending phlashes for me to view
```
```
as a user
so that I can sue the sender of the horrible picture
I want to know the sender of each phlash
```
```
As a user
So that I enjoy using the app
I want the follow page to be animated when it appears/disappears
```
```
As a phlaser
so that I accurately guided through the app
I want to have alerts with info on main events
```
```
as a developer
so that no malicious users access the backend functionality
I want to move some of the Parse calls up into Cloud Coded
```
```
as a developer
so that the app has sensible limits
I want to have authentication text field validations for usernames, emails and passwords
```
```
as a developer
so that my app has sensible limits
I want to ensure that caption does not exceed the limits and fits nicely in the screen
```
```
as a artistic Phlaser
so that I can create a meme style phlash
I want to be able to position my text in the taken phlash
```
```
as a Phlaser
in order to increase the app usability
I want the keyboard to be dismissed from the Auth view in the relevant ways
```
```
as a developer
so that I have cracking app
I want to present the sender label in a cracking way
```
```
as a developer
so that my application is efficient in database queries
I want to check the database only if there is not photos locally to show
```
```
as a user
so that I want to use the app over and over
I want to have a fancy app design
```
```
as a developer
so that my user can't misuse the app
I want to temporarily disable buttons and swipes after use to prevent double tapping/swipping
```
```
as a developer
so that my app works smoothly
I want to validate the user to phollow exists before adding the relationship to the database
```
```  
as a developer
so that phlasers use the app appropriately
I want to ensure I can't phollow someone twice
```  
```
as I user
so that I know how to use Phlash
I want to get a initial screen with instructions
```
```
as a user
so that to just see fresh images
I want to see all the new images of my phollowees since the last time I checked them
```  
```
as a user
so that I can phlash nice selphies
I want to be able to choose between front or rear camera to take my phlash
```  
```
as a developer
so that all the usernames of phollowees are standard
I want to validate that field and ensure no capital letters, less than 15 chars and no symbols are allowed
```  
```
as a user
so that I can edit my list of people I follow
I want to be able to unphollow a person
```  
```
as a developer
so that the app is appealing
I want to have a phlashy design
```  
```
as a developer
so that my app is widely distributed
I want my app to be run in many different iOS versions, (from 7.0 till 9.0)
```
```
as a developer
so that I can drive my user nicely
I want the keyboard to start with lower cases
```

## To Do
- Manage list of Phollowers
- Create videos
- Geolocalise phlashers and show them in a map

## Detailed plan
Our detailed plan is [here](https://www.youtube.com/watch?v=LfmrHTdXgK4). 
(probably the best detailed plan ever, don't miss it :))
