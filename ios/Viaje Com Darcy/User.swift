import Foundation

class User {
    
    private let _id: String?
    private var _name: String?
    
    var id: String! {
        return _id
    }
    
    var name: String? {
        return _name
    }
    
    init(id: String!, name: String?) {
        self._id = id
        self._name = name
    }
    
}