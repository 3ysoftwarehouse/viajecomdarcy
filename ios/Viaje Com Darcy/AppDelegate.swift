import UIKit
import Parse
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var container: Container!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        initializeParse()
        initializeDependencyContainer()
        initializeStoryboard()
        return true
    }
    
    func initializeParse() {
        Parse.initializeWithConfiguration(ParseClientConfiguration { (configuration) in
            configuration.applicationId = "HYCy74Id5nqiRN2Sf4zGJ0ge9lMd97aaZcHiH7Uj"
            configuration.clientKey = "64BXIdOCvAra0SlbGRbTW2RYkzBgx3vbVIagZzSN"
        })
    }
    
    func initializeDependencyContainer() {
        self.container = Container { (container) in
            
            container.register(ParseUserToUserConverter.self) { _ in ParseUserToUserConverter() }
            
            container.register(UserService.self) { resolver in
                ParseUserService(parseUserConverter: resolver.resolve(ParseUserToUserConverter.self)!)
            }
            
            container.registerForStoryboard(LoginViewController.self, initCompleted: { (resolver, controller) in
                controller.userService = resolver.resolve(UserService.self)
            })
            
            container.registerForStoryboard(ChallengeViewController.self, initCompleted: { (resolver, controller) in
                
            })
        }
    }
    
    func initializeStoryboard() {
        let window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window.makeKeyAndVisible()
        self.window = window
        
        let storyboard = SwinjectStoryboard.create(name: "Main", bundle: nil, container: container)
        window.rootViewController = storyboard.instantiateInitialViewController()
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

