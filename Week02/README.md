# BullsEye Game

### Problem Summery
I was asked to learn the MVC pattern and refactor the existing apps so that those apps follow the MVC architecture pattern.

### Struct vs Class
In this homework, I chose class instead of struct for the model named BullsEyeGame. Because in BullsEyeGame I have multiple mutable properties that will be changed multiple times throughout the game. If I use struct here then I have to use the mutating keyword before every method where the properties will be changed. This will be verbose to read. 

Also, if I choose struct here, to change the property I have to use var instead of let for the BullsEyeGame object as I have to call mutating methods to change properties. var will allow me to change the object itself. This might lead to a bug in the future. Here I want the reference to be fixed after fist initialization and I just want to change the properties of the object. In this scenario, I think the class is a better choice.