//
//  Hack_Change23Track1App.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import SwiftUI

@main
struct Hack_Change23Track1App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
        
//    static var orientationLock = UIInterfaceOrientationMask.portrait {
//        didSet {
//            UIApplication.shared.connectedScenes.forEach { scene in
//                if let windowScene = scene as? UIWindowScene {
//                    windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: orientationLock))
//                }
//            }
//            UIApplication.navigationTopViewController()?.setNeedsUpdateOfSupportedInterfaceOrientations()
//        }
//    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    
//    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
//        return AppDelegate.orientationLock
//    }
}


//extension View {
//    @ViewBuilder
//    func forceRotation(orientation: UIInterfaceOrientationMask) -> some View {
//        if UIDevice.current.userInterfaceIdiom == .phone {
//            self
//                .onAppear() {
//                    AppDelegate.orientationLock = orientation
//                }
//                .onDisappear() {
//                    let currentOrientation = AppDelegate.orientationLock
//                    AppDelegate.orientationLock = currentOrientation
//                }
//        }
//    }
//}


struct SupportedOrientationsPreferenceKey: PreferenceKey {
    typealias Value = UIInterfaceOrientationMask
    static var defaultValue: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return .all
        }
        else {
            return .portrait
        }
    }
    
    static func reduce(value: inout UIInterfaceOrientationMask, nextValue: () -> UIInterfaceOrientationMask) {
        // use the most restrictive set from the stack
        value.formIntersection(nextValue())
    }
}

/// Use this in place of `UIHostingController` in your app's `SceneDelegate`.
///
/// Supported interface orientations come from the root of the view hierarchy.
class OrientationLockedController<Content: View>: UIHostingController<OrientationLockedController.Root<Content>> {
    class Box {
        var supportedOrientations: UIInterfaceOrientationMask
        init() {
            self.supportedOrientations =
                UIDevice.current.userInterfaceIdiom == .pad
                    ? .all
                    : .allButUpsideDown
        }
    }
    
    var orientations: Box!
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        orientations.supportedOrientations
    }
    
    init(rootView: Content) {
        let box = Box()
        let orientationRoot = Root(contentView: rootView, box: box)
        super.init(rootView: orientationRoot)
        self.orientations = box
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    struct Root<Content: View>: View {
        let contentView: Content
        let box: Box
        
        var body: some View {
            contentView
                .onPreferenceChange(SupportedOrientationsPreferenceKey.self) { value in
                    // Update the binding to set the value on the root controller.
                    self.box.supportedOrientations = value
            }
        }
    }
}

extension View {
    func supportedOrientations(_ supportedOrientations: UIInterfaceOrientationMask) -> some View {
        // When rendered, export the requested orientations upward to Root
        preference(key: SupportedOrientationsPreferenceKey.self, value: supportedOrientations)
    }
}
