//
// Created by Arveen kumar on 18/01/2021.
//

import Foundation
import UIKit
import Adaptr

class AppDelegate: NSObject, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AdaptrAudioPlayer.setClientToken("3W1ic1clDhfaHVOI39SmpolJUNq0z9m771QAL5UbG9uhUpdMUHnJLyaTmQZ9angT", secret: "cBmLA1rvgKdwV08wPOvGfTNRRI94txZ0yRkdZocWssa5PlLMqj5qPdUWTh5Yi64V")
        ADLogSetLevel(ADLogLevelDebug)
        // Override point for customization after application launch.
        #if DEBUG
        Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle")?.load()
        //for tvOS:
        //Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/tvOSInjection.bundle")?.load()
        //Or for macOS:
        //Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/macOSInjection.bundle")?.load()
        #endif
        return true
    }
}
