//
//  AppDelegate.swift
//  TextScan
//
//  Created by Apple on 2023/11/9.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift
import CoreData
import AVFoundation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var debugInput: String?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        let tabBar = BaseTabBarVC()
//        let tabBar = SwiftWhisper()
        self.window?.rootViewController = tabBar
        self.window?.makeKeyAndVisible()
        setupVoice()

        return true
    }
    
    func setupVoice() {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSession.Category.playAndRecord, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
            if let input = session.availableInputs{
                debugInput = input.reduce("", { (result, desp) -> String in
                    result + desp.debugDescription + "\n\n"
                })
            }
            try session.setActive(true)
            session.requestRecordPermission({ (isGranted: Bool) in
                if isGranted {
                    appHasMicAccess = true
                }
                else{
                    appHasMicAccess = false
                }
            })
        } catch let error as NSError {
            print("AVAudioSession configuration error: \(error.localizedDescription)")
        }
    }
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        }
     
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
     
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
     
    func applicationDidBecomeActive(_ application: UIApplication) {
 
    }
     
    func applicationWillTerminate(_ application: UIApplication) {
    }
     
        // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "hangge_1841")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

