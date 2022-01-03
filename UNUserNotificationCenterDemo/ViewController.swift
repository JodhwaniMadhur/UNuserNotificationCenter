//
//  ViewController.swift
//  UNUserNotificationCenterDemo
//
//  Created by Madhur Jodhwani on 03/01/22.
//

import Cocoa
import Foundation
import UserNotifications

class ViewController: NSViewController {

    let un=UNUserNotificationCenter.current()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func notifyUser(_ sender: Any) {
        un.requestAuthorization(options: [.alert,.badge,.criticalAlert,.sound]) { authorized, error in
            if authorized{
                print("Authorized")
            }else if !authorized {
                print("not authorized")
            }else{
                print(error?.localizedDescription as Any)
            }
        }
        un.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized{
                
                
                let id=UUID().uuidString//id can be any string
                //creating a trigger for UNNotificationRequest
                let trigger=UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
                
                //creating and adding content to UNMutuableNotificationContent that we want to display.
                let content=UNMutableNotificationContent()
                content.title=NSUserName()
                content.subtitle="🚀💥🧀🧼📅"
                content.body="This is a test notification"
                content.sound=UNNotificationSound.default
                
                
                //create file path for image asset
                let filePath = Bundle.main.path(forResource: "images", ofType: ".png")
                //convert it to URL
                let fileUrl = URL(fileURLWithPath: filePath!)
                
                do{
                    let attachment=try UNNotificationAttachment.init(identifier: id, url: fileUrl, options: .none)
                    content.attachments=[attachment]
                }catch let error{
                    print(error.localizedDescription)
                }
                
                
                
                //create request
                let request=UNNotificationRequest(identifier: id, content: content, trigger: trigger)
                
                
                
                //call the UNUserNotificationCenter with our request object.
                self.un.add(request) { error in
                    if error != nil{
                        print(error?.localizedDescription as Any)
                    }
                }
            }
        }
    }
    
}



