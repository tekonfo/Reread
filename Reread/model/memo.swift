import UIKit
import RealmSwift

class Memos: Object {
    let impression = LinkingObjects(fromType: Impressions.self, property: "memos") //Impressionsへの逆方向のリレーションである。propertyの値はIMpressionsの中にあるMemoの中から自分とマッチしているものを選択する。取得する。
    @objc dynamic var memo = ""
    @objc dynamic var date = Date()
}

