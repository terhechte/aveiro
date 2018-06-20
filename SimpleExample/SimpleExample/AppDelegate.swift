import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var arrayController: NSArrayController!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        arrayController.content = NSMutableArray(array: Model.developers)
    }
}

