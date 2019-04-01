# WeatherAppVIP - weather app architecture demo.
## Introduction
This project is to demonstrate some of the architectural approaches I use in app development as well as provide a skeleton structure and reference. It is fully functional and covered with unit tests. The approach is based on clean architecture plus SOLID principles and, more specifically, the clean swift VIP approach with some elements borrowed from the VIPER setup using protocol oriented programming. It is intended to be used in larger scale apps written by bigger teams.

Clean architecture reference http://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html
Clean swift VIP reference https://clean-swift.com/

The main aim of the architecture is to create easily reusable replaceable, testable, stable components that clearly define the boundaries of their responsibilities and associated logic.

The whole implementation is native and does not have any 3rd party library dependencies. A single storyboard is used but can be switched to multiple storyboards or individidual xib files as needed for larger projects. 

The app uses https://www.apixu.com weather api.

## Structure
### Screens
Each screen has 6 related classes. The data flow follows the main VIP pattern which is a closed circle of  `View -> Interactor -> Presenter -> View` plus the `Router` and `Configurator` classes providing navigation and configuration as described below. Each element of the 3 part circle has an `output` and an `input`. An `output` of one element has to be the `input` of the next element in the chain.

Let's take the `MainWeather` screen as an example. 

`MainWeatherContracts` - This contains a set of protocols that are used by the classes in this screen. This makes it very easy to see how the data is passed between the different classes.  For example `MainWeatherInteractorInput` adopts `MainWeatherViewOutput` so whatever the `MainWeatherView` outputs has to be accepted by the `MainWeatherInteractor`.

`MainWeatherConfigurator` - This class is just used for putting together all of the components together. Since all of the components are based on protocols they adopt I want to decouple the concrete class initialisation from any of the main components. That way none of the classes know or care about the actual class of any other class that they keep a reference to - they just have the protocols to work with.
The root viewController creates its own configurator but subsequent viewControllers don't. That way the router that takes the user to any specific screen can decide which configurator and which view to create and show.

`MainWeatherRouter` - This class is used for navigation between different screens and passing data between them. This ensures that the view does not depend on or even know about any of the other views.

`MainWeatherInteractor` - These are the use case containers.  They contain non-ui related business logic. Interactors decouple the data workers from anything UI related. You can create multiple interactors if the use cases are very complex or different.

`MainWeatherPresenter` - After the interactor did any data related business logic or fetched data/error from the workers it passes the results to the presenter. Presenter then processes that response into a presentable state and applies UI logic. For example it applies date formatting, enables text editing or decides whether an alert should be shown after getting an error response.

`MainWeatherViewController` - Presentable viewModel coming out of the presenter class must contain simple data that can be presented by the viewController as is. No business or data logic should be contained in this class. It does contains static data such as title labels, static colours or images, content dimensions and so on. These variables are not changed during the lifecycle of the view and thus don't need to be passed in from the outside. The view does have logic on how to display the data sent over by the presenter. For example if the presenter output shows that an alert must be shown with a given message the view implementation decides whether to show a system alert, a custom banner, popup or something else.
Any actions taken by the user are passed to its output which is normally the interactor. This ensures that each action will go through the interactor and a presenter allowing them to apply any appropriate logic.

### Supporting classes
`Worker` - A class used by the interactors to manipulate the data. This can be a network worker like in this example, Core Data, Realm, UserDefaults, LocationManager, Camera or any other type depending on what sort of data the interactor needs to access or manipulate. They are also based on protocols which means they can be easily replaced by different providers without affecting the interactor code.

`DataModels` - These are the app entities. Regular structures that represent any external data object. They are created within the workers and are then passed through the interactor to the presenter. They must not be passed to the view to make sure that any changes in the DataModels don't affect the UI code in any way.

`ViewModels` - enums containing structs. Therse are used to pass data around the VIP circle. View sends requests to the interactor, interactor sends responses to the presenter, presenter sends viewModels to the view. They encapsulate the data being passed around to make the code clearer. These are usually screen specific and contain simple data that is used within that specific VIP cycle.
These must not be passed to the interactor to make sure that any changes in what is presented does not affect the business or data interaction code.

## Discussion
The benefits of using clean architecture and the SOLID principles include:
1. Framework, database and UI independency - since workers abstract the different 3rd party data libraries and frameworks while views abstract the UI related components all the other components are not affected by changing them around. If a Core Data worker is replaced by a Realm worker none of the other app parts would be affected because the new worker has to conform to the same protocol as the old worker. If an OpenCV framework is replaced by a ML framework that also does text recognition only the worker would change. Also if an alert is changed from being displayed in a system popup to a custom one only the view would be aware of that change. 
2. Testable - each component is independent from each other and external dependencies can be easily mocked due to polymorphism so it's very easy to write tests as shown in the project.
3. Independent of external conditinos - the business rules don't know anything about what happens outside of the app. Workers abstract that on the data side while the views abstract that on the user facing interface side.
