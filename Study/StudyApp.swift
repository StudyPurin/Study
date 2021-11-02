//
//  StudyApp.swift
//  Study
//
//  Created by cmStudent on 2021/10/04.
//
import SwiftUI

@main
struct StudyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {

    var backgroundTaskId: UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier(rawValue: 0)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        print("アプリ閉じそうな時に呼ばれる")
        self.backgroundTaskId = application.beginBackgroundTask(withName: ""){
            [weak self] in
            application.endBackgroundTask((self?.backgroundTaskId)!)
            self?.backgroundTaskId = UIBackgroundTaskIdentifier.invalid
        }
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        print("アプリを閉じた時に呼ばれる")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print("アプリを開きそうな時に呼ばれる")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        print("アプリを開いた時に呼ばれる")
        application.endBackgroundTask(self.backgroundTaskId)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print("フリックしてアプリを終了させた時に呼ばれる")
    }

}


struct SimpleTimer_Previews: PreviewProvider {
    static var previews: some View {
            ContentView()
    }
}
