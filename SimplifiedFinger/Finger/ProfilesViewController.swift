import AppKit
import WebKit

/// What could this be for?
final class PRWebViewController: NSObjectController {
    @IBOutlet var webView: WebView?
    
    private func openPR() {
        guard let pr = (content as? [PullRequest])?.first else { return }
        webView?.mainFrame.loadHTMLString(pr.html, baseURL: URL(string: "http://localhost"))
    }
    
    @IBAction func openInBrowser(sender: AnyObject) {
        guard let pr = (content as? [PullRequest])?.first else { return }
        let alert = NSAlert()
        alert.informativeText = pr.title
        alert.addButton(withTitle: "Ok")
        alert.runModal()
    }
}

final class ProfileViewController: NSViewController {
    
    @IBOutlet var profilesArrayController: NSArrayController?
    @IBOutlet var pullRequestsArrayController: NSArrayController?
    
    @objc dynamic var selectedProfile: IndexSet? {
        didSet {
            // Imagine we're doing a HTTP lookup to get the pull requests
            guard let profiles = profilesArrayController?.arrangedObjects as? [Profile],
                let index = selectedProfile?.first else { return }
            Model.pullRequests(for: profiles[index]) { (prs) in
                self.pullRequestsArrayController?.content = prs
            }
        }
    }
    
    override func awakeFromNib() {
        profilesArrayController?.content = NSMutableArray(array: Model.users)
        profilesArrayController?.sortDescriptors = [
            NSSortDescriptor(key: "sortStatus", ascending: true),
            NSSortDescriptor(key: "updated", ascending: true)
        ]
    }
    
    
}
