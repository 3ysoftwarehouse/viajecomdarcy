import Foundation
import Parse

class UserParseService: UserService {
    
    private let parseUserConverter: ParseUserToUserConverter!
    
    init(parseUserConverter: ParseUserToUserConverter) {
        self.parseUserConverter = parseUserConverter
    }
    
    func authenticate(username: String!, password: String!, block: (user: User?) -> Void) {
        PFUser.logInWithUsernameInBackground(username, password: password) { (parseUser, error) in
            if let parseUser = parseUser {
                block(user: self.parseUserConverter.convert(parseUser))
            } else {
                block(user: nil)
            }
        }
    }
    
    func isAuthenticated() -> Bool {
        return PFUser.currentUser() != nil
    }
    
}