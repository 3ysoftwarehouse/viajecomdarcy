import Foundation

protocol UserService {
    func authenticate(username: String!, password: String!, block: (user: User?) -> Void)
}