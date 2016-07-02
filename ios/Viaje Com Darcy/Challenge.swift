import Foundation

class Challenge {
    
    private let _id: String!
    private let _title: String!
    private var _description: String?
    
    var id: String! {
        return _id
    }
    
    var title: String! {
        return _title
    }
    
    var description: String? {
        return _description
    }
        
    init(id: String!, title: String!) {
        self._id = id
        self._title = title
    }
    
    convenience init(id: String!, title: String!, description: String?) {
        self.init(id: id, title: title)
        self._description = description
    }
    
}