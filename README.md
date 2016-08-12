# Product Compatibility iOS Application
## Angel Lozano, Summer 2016

Xcode Version: 7.3.1
**Clone the repository to your local machine, navigate to the directory and do 'pod install' to build the pods used in this project.**

Pod File:

target 'productCompatibility' do

  pod 'Alamofire', '~> 3.4'
  pod 'Alamofire-Synchronous', '~> 3.0'
  pod 'SwiftyJSON'
  pod 'Material', '~> 1.0'
  pod 'Kingfisher', '~> 2.4'
  pod 'SwiftSpinner'
  
end

The latest version of the application contains the Podfile above. Please update accordingly.

1. Alamofire: Alamofire was used to create HTTP networking requests from and to the Ruby on Rails application which shaped and modeled all of our input data.
2. Alamofire-Synchronous: This pod was used because Alamofire's networking calls are done asynchronously. Now, since I do not use Core Data in the application, all data has to be requested form the RESTful API at the moment. In an application like this, it wouldn't be very useful to use Core Data since the requested and pulled data might change from call to call. However, since Alamofire was done asynchronously, some of my TableViewController classes would not get updated in time since the data was not present. Used this pod to allow the networking request to come in synchronously and load the data right away.
3. SwiftyJSON: SwiftyJSON was used to handle all JSON requests that came in from Alamofire. Very simple but powerful pod to use.
4. Material: Material was the pod used for most UI aspects of the application. A button in Swift is of the UIButton class. You would create a button through Storyboard and then change it's class to Material's button class, allowing you to create even cooler UI.
5. Kingfisher: Not used but forgot to remove it.
6. SwiftSpinner: SwiftSpinner was used mainly to create a activity indicator for when the loading time would take too long. You can at least inform the user that some data pulling is happening in the background while they wait. This is mainly used whenever the user inputs a SKU and is expecting the compatible/incompatible lists of products.

