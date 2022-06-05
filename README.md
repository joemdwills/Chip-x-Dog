# Chip-x-Dog
Repository for the take-home challenge for the iOS Developer application to Chip Financial Ltd.

## Implementation
## UI Architecture Patern
I chose to implement an MVVM Design Architecture for this challenge with the two main views (Initial (List) & Detail View (Dog Images)). 

### Pros:
- Decoupling logic from the UI to enable in-depth unit testing
- De-clutter view code

### Cons:
- Design architecture requires additional files and work to setup

## The Dog API


### Pros:
- Implemented Asynchronous methods to make use of the device's background threads to complete the API requests

### Cons:

## Internet only App
The application currently doesn't implement any logic to store the data locally (on-device). So it would not worl if the user did not have an internet connection.

### Pros:
- Application size is small
- App will show latest data from the API (currently no way to track any changes made in the API)

### Cons:
- User gets a bad experience when using the App with poor or no internet connection

# Personal Review
Overall, I feel the application does what is required by the brief giving a user an ability to look at the vast amount of Dog breeds and then when they tap on one they are presented with a collection of 10 random images of that type. 

However, there is always room for improvement and therefore if I were to take this to v2 I would implement the following:

## Replace Completion Handlers with Async/Await methods or use Combine

## Add a CoreData Model
- So that users would be able to use the app without internet after an initial set of requests
- Save the list of Dogs and then either create a data object for each Dog when they select one from the list adding it to the model.

A CoreData Model should then enable me to do the following:

## Search Field (by name or type)
Adding the ManagedObjectContext to the List view would enable me to query the data model with by either the Dog Breed Name or by Sub-Breed, giving the user a better experience.

## More detail for each row object in the list
The current list view is very boring and pretty impossible to identify Dog Breed quickly. Adding an imagecould give the user just enough detail so that it makes journey of finding a specific breed, quicker.
