# CakeList

A simple iOS application that loads and displays a list of cakes from the Waracle coding exercise API.

## Requirements

- Xcode 14.2 or later
- iOS 16.2 or later
- Swift 5.7
- SwiftUI

## Running the project

1. Clone the repository:

   git clone https://github.com/ShikhaIos/cake-list.git

2. Open the Xcode project.

3. Select an iOS simulator or physical device.

4. Run the application using Cmd + R.

No additional dependencies or setup are required.

## Architecture

The app uses MVVM with a lightweight Repository layer.

CakeListView
    ↓
CakeListViewModel
    ↓
CakeRepository
    ↓
CakeAPIService
    ↓
Waracle API

### CakeAPIService

Responsible for making the HTTP request and decoding the API response.

### CakeRepository

Provides the data-access abstraction used by the ViewModel.

### CakeListViewModel

Responsible for screen state and business behaviour including:

- Loading cakes
- Removing duplicates
- Sorting cakes alphabetically
- Handling loading and error states
- Refreshing the list

### CakeListView

Responsible only for displaying the current UI state.

## Assumptions

The API does not provide a unique identifier for cakes.

For this exercise, cakes with the same title are considered duplicates, using a case-insensitive comparison.

## Error handling

If loading fails, the application displays an error message and provides a retry option.

## Refresh

Pull-to-refresh reloads the cake list from the API.

## Testing

Unit tests cover the business behaviour required by the exercise:

- Successful loading removes duplicates and sorts cakes by title.
- Failed loading results in an error state.

Run tests in Xcode using:

Cmd + U

## Technology choices

### URLSession

URLSession is used instead of a third-party networking framework because the application only requires a single simple HTTP GET request.

### AsyncImage

SwiftUI AsyncImage is used for remote images to avoid introducing an unnecessary image-loading dependency for this exercise.

### MVVM

MVVM keeps UI rendering separate from application behaviour and allows the ViewModel to be unit tested independently using a fake repository.

