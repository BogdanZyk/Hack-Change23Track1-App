//
//  Orientation.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 04.12.2023.
//

import SwiftUI
import Combine

final class OrientationManager: ObservableObject {
    @Published var type: UIDeviceOrientation = .portrait
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        guard let scene = UIApplication.shared.connectedScenes.first,
              let sceneDelegate = scene as? UIWindowScene else { return }
        
        let orientation = sceneDelegate.interfaceOrientation
        
        switch orientation {
            case .portrait: type = .portrait
            case .portraitUpsideDown: type = .portraitUpsideDown
            case .landscapeLeft: type = .landscapeLeft
            case .landscapeRight: type = .landscapeRight
                
            default: type = .unknown
        }
        
        NotificationCenter.default
            .publisher(for: UIDevice.orientationDidChangeNotification)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.type = UIDevice.current.orientation
            }
            .store(in: &cancellables)
    }
    
    public func changeOrientation(to orientation: UIInterfaceOrientationMask) {
        // tell the app to change the orientation
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: orientation))
        if orientation == .landscape {
            type = .landscapeRight
        } else {
            type = .portrait
        }
    }
}

struct OrientationKey: EnvironmentKey {
    static let defaultValue = OrientationManager()
}

extension EnvironmentValues {
    var orientation: OrientationManager {
        get { return self[OrientationKey.self] }
        set { self[OrientationKey.self] = newValue }
    }
}

extension UIDeviceOrientation {
    var isLandscape: Bool {
        switch self {
        case .landscapeLeft, .landscapeRight, .portraitUpsideDown:
            return true
        default:
            return false
        }
    }
}
