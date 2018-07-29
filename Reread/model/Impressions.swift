

import UIKit
import RealmSwift

class Impressions: Object {
    @objc dynamic var title = ""
    @objc dynamic var creator = ""
    let memos = List<Memos>() //Catモデルと1対多の関連
    @objc dynamic var date = Date()
}
