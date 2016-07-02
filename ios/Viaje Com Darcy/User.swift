import Foundation

class User {
    private var _name: String?
    
    var name: String? {
        return _name
    }
    
    init(name: String?) {
        self._name = name
    }
    
}