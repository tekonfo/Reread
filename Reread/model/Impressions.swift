

import UIKit
import RealmSwift

class Impressions: Object {
    @objc dynamic var memo = ""
    @objc dynamic var title = ""
    @objc dynamic var creator = ""
    @objc dynamic var date = Date()
}
