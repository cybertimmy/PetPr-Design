import Foundation
import RealmSwift

class TaskRealm: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name: String = ""
    @objc dynamic var isCompleted = false
    @objc dynamic var dueDate: Date? = nil
    
    var tasks: Results<TaskRealm>!
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
