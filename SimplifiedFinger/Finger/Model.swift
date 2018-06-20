import Foundation
import AppKit.NSImage

/// Here be dragons

final class PullRequest: NSObject {
    @objc var title: String
    @objc var commits: Int
    @objc var comments: Int
    @objc var updated: Date
    @objc var seen: Bool
    @objc var html: String
    init(_ title: String, commits: Int, comments: Int, updated: Date) {
        self.title = title
        self.commits = commits
        self.comments = comments
        self.updated = updated
        self.seen = false
        self.html = "<html><body>This could be github!</body></html>"
    }
}

let allWords = "Attributes Author Cocoa Controller Editable For However Info Key Model NSString Note Path The able already and application are arrangedObjectsauthorlastname array array array; aspects author authorlastname author’s behavior binding bound can case cells change coding column column column concatenated default deselect display don’t editable editing example from get identifies instances key key-value last lists name name names object objects pane path property retrieve returned run select set simply some table text that the therefore this users uses value views want well when will window with work you your".split(separator: " ")

let profiles = ["p1", "p2", "p3", "p4"]

final class Profile: NSObject {
    
    public override class func keyPathsForValuesAffectingValue(forKey key: String) -> Set<String> {
        switch key {
        case "sortStatus": return Set(["status"])
        default: return Set([])
        }
    }
    
    @objc var username: String?
    @objc var profilePicture: NSImage?
    @objc var stati: [String] = ["Updated", "Reviewing", "Marked", "Seen"]
    @objc var status: String = "Updated"
    @objc var sortStatus: Int {
        return stati.index(of: status) ?? 100
    }
    @objc var updated: Date
    init(_ username: String, profilePicture: NSImage?, bio: String?) {
        self.username = username
        self.profilePicture = profilePicture
        let current: Int = Int(Date().timeIntervalSince1970)
        let updated: Int = Int(current - Int(100000 + arc4random_uniform(1000000)))
        self.updated = Date(timeIntervalSince1970: TimeInterval(updated))
    }
}

final class Model {
    static var users: [Profile] = [
        Profile("Franz Jochen", profilePicture: NSImage(named: NSImage.Name(rawValue: "p1")), bio: nil),
        Profile("Klaus Kalrsen", profilePicture: NSImage(named: NSImage.Name(rawValue: "p2")), bio: nil),
        Profile("Mario Jepping", profilePicture: NSImage(named: NSImage.Name(rawValue: "p3")), bio: nil),
        Profile("Tobias Kemper", profilePicture: NSImage(named: NSImage.Name(rawValue: "p4")), bio: nil),
    ]
    
    static func pullRequests(for profile: Profile, completion: ([PullRequest]) -> Void) {
        let pullRequests: [PullRequest] = (0..<(Int(3 + arc4random_uniform(30)))).map { number in
            let titleCount = Int(10 + arc4random_uniform(40))
            var title = ""
            (0..<titleCount).forEach { _ in
                let idx = Int(arc4random_uniform(UInt32(allWords.count - 1)))
                title.append("\(allWords[idx]) ")
            }
            let commits = Int(10 + arc4random_uniform(100))
            let current: Int = Int(Date().timeIntervalSince1970)
            let updated: Int = Int(current - Int(100000 + arc4random_uniform(1000000)))
            return PullRequest(title, commits: commits, comments: Int(3 + arc4random_uniform(20)), updated: Date(timeIntervalSince1970: TimeInterval(updated)))
        }
        completion(pullRequests)
    }
}
