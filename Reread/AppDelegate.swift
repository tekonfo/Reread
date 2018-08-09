import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var message:String = ""  
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let config = Realm.Configuration(
            schemaVersion: 5,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 5) {
                }
        })
        Realm.Configuration.defaultConfiguration = config
        _ = try! Realm()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        }

    func applicationDidEnterBackground(_ application: UIApplication) {
        }

    func applicationWillEnterForeground(_ application: UIApplication) {
        }

    func applicationDidBecomeActive(_ application: UIApplication) {
        }

    func applicationWillTerminate(_ application: UIApplication) {
        }
}

