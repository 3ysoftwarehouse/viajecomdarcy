import Foundation
import Parse

class ParseUserToUserConverter {
    
    func convert(parseUser: PFUser!) -> User {
        let name = parseUser.valueForKey("name") as? String
        return User(name: name)
    }
    
}