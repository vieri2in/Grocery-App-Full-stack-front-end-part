# Grocery-App-Full-stack-front-end-part
**This app is the user interface by SwiftUI of the Grocery-App-Full-stack-project. It has a dependency on the GroceryAppSharedDTO package. Besides its support for login and registration, this app allows users to display, create, update, and delete data, which is fetched and stored remotely via a web server. Moreover, the design of the app features the MV patten that eliminates the view models of MVVM pattern while introducing the aggregate root model that allows access to the entities/models under a certain bounded context.**

## Login and registration
<img alt="login" src="https://github.com/vieri2in/Grocery-App-Full-stack-front-end-part/assets/97074757/b93f2ec1-f9bd-4e5b-825a-264e7e83b823" width=25% height=25%> 

## Communication between the front-end and back-end.
**Before:**

<img alt="previous" src="https://github.com/vieri2in/Grocery-App-Full-stack-front-end-part/assets/97074757/046a37a8-8692-4b5b-ad69-f26caf0009bb" width=25% height=25%> <img alt="login" src="https://github.com/vieri2in/Grocery-App-Full-stack-front-end-part/assets/97074757/f407701b-d3de-4a95-b7ea-903dd2437371" width=25% height=25%> <img alt="previous" src="https://github.com/vieri2in/Grocery-App-Full-stack-front-end-part/assets/97074757/95a824b5-4080-42db-8487-cde6370ab121" width=85% height=85%>

**After:**

<img alt="login" src="https://github.com/vieri2in/Grocery-App-Full-stack-front-end-part/assets/97074757/3abdd83b-c2a6-4121-903b-3d819f523283" width=25% height=25%> <img alt="previous" src="https://github.com/vieri2in/Grocery-App-Full-stack-front-end-part/assets/97074757/fe44ac89-953c-48f0-8d4e-79c0553b2e69" width=85% height=85%>

## MV pattern
This pattern is suited to the client/server app. Besides the models and views, this architecture includes an aggregate model, webservice and the server. Unlike the MVVM pattern that asks each views correspondes to a view model, the MV pattern allows multiple views communicate with the aggregate root model to fetch, persist, sort different models. To perform its job, the aggregate root model needs to invoke a web service.

<img alt="login" src="https://github.com/vieri2in/Grocery-App-Full-stack-front-end-part/assets/97074757/556693a0-966b-4a67-a947-b2c9ceec5058" width=75% height=75%> 

<img alt="login" src="https://github.com/vieri2in/Grocery-App-Full-stack-front-end-part/assets/97074757/64aa7e20-a89d-443c-b9b0-fb88185b757c" width=18% height=18%> 

**Aggregate root model:**

<img alt="login" src="https://github.com/vieri2in/Grocery-App-Full-stack-front-end-part/assets/97074757/882ed72e-94be-4ad5-a910-7a539d407434" width=85% height=85%> 

**Views:**

<img alt="login" src="https://github.com/vieri2in/Grocery-App-Full-stack-front-end-part/assets/97074757/41b8eb6f-f73e-4bb4-ba73-e7c2571c02bb" width=45% height=45%> <img alt="login" src="https://github.com/vieri2in/Grocery-App-Full-stack-front-end-part/assets/97074757/72183eff-e4d7-4c62-86fc-cca6ba2d1546" width=45% height=45%> 

## Global navigation
The approach is to handle all the routes in the root view of the application.

<img alt="login" src="https://github.com/vieri2in/Grocery-App-Full-stack-front-end-part/assets/97074757/bc16ae24-0925-4ab5-ade0-9adaa0600354" width=45% height=45%> <img alt="login" src="https://github.com/vieri2in/Grocery-App-Full-stack-front-end-part/assets/97074757/44b34ce7-3672-4e5b-924a-cad7fdd02f44" width=55% height=55%> 

## Container/Presentation pattern
This pattern makes presentation views free of any dependencies by passing the data from the parent view to the child view.

**Child view:**

<img alt="login" src="https://github.com/vieri2in/Grocery-App-Full-stack-front-end-part/assets/97074757/913a0209-0848-475e-a95d-3ed7147d392b" width=45% height=45%> 

**Parent view:**

<img alt="login" src="https://github.com/vieri2in/Grocery-App-Full-stack-front-end-part/assets/97074757/f935a3a0-300f-4d67-ac8c-1bd622def4ab" width=60% height=60%> 


## Acknowledgment:
The code and pic originate from Mohammad Azam's Udemy course: Mastering Full Stack iOS Development Using SwiftUI and Vapor. This course is a good example of the MV pattern advocated by Azam in his articles and courses. I spent two weeks following this amazing course bit by bit and was impressed by the way he designs and organizes code. His teaching answers many of my previous questions when applying the MVVM pattern to my projects. As an IOS apprentice, I at times am struggling with how to get things done, not to mention writing sleek, clean code. But contemplating the code written by brilliant programmers like Azam can help me write elegant, skilled code in the future.
