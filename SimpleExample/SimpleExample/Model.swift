import Foundation

public class Developer: NSObject {
    @objc public var username: String
    @objc public var openSourceRepos: Int
    
    init(username: String, openSourceRepos: Int) {
        (self.username, self.openSourceRepos) = (username, openSourceRepos)
        super.init()
    }
    
    override init() {
        (self.username, self.openSourceRepos) = ("No One", 0)
        super.init()
    }
}

public struct Model {
    static var developers: [Developer] {
        return [
            Developer(username: "codeguy", openSourceRepos: 10),
            Developer(username: "zealot", openSourceRepos: 1),
            Developer(username: "harmstrung", openSourceRepos: 23),
            Developer(username: "kernelhacker", openSourceRepos: 199),
            Developer(username: "cored0mp", openSourceRepos: 7)
        ]
    }
}
