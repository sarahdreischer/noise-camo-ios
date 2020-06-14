////
////  SpotifyManager.swift
////  noise-camo-app
////
////  Created by Sarah Dreischer on 11/06/2020.
////  Copyright © 2020 Sarah Dreischer. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//class SpotifyManager: NSObject, ObservableObject, SPTAppRemoteDelegate {
//    static private let kAccessTokenKey = "access-token-key"
//    private let SpotifyClientID = "4fbef720ee6f499792d426ca2f56beb7"
//    private let SpotifyRedirectURI = URL(string: "spotify-ios-quick-start://spotify-login-callback")!
//    
//    var window: UIWindow?
//    
//    lazy var appRemote: SPTAppRemote = {
//        let configuration = SPTConfiguration(clientID: self.clientIdentifier, redirectURL: self.redirectUri)
//        let appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
//        appRemote.connectionParameters.accessToken = self.accessToken
//        appRemote.delegate = self
//        return appRemote
//    }()
//
//    var accessToken = UserDefaults.standard.string(forKey: kAccessTokenKey) {
//        didSet {
//            let defaults = UserDefaults.standard
//            defaults.set(accessToken, forKey: SceneDelegate.kAccessTokenKey)
//        }
//    }
//    
//    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
//        guard let url = URLContexts.first?.url else {
//            return
//        }
//
//        let parameters = appRemote.authorizationParameters(from: url);
//
//        if let access_token = parameters?[SPTAppRemoteAccessTokenKey] {
//            appRemote.connectionParameters.accessToken = access_token
//            self.accessToken = access_token
//        } else if let _ = parameters?[SPTAppRemoteErrorDescriptionKey] {
//            // Show the error
//        }
//
//    }
//
//    func sceneDidBecomeActive(_ scene: UIScene) {
//        connect();
//    }
//
//    func sceneWillResignActive(_ scene: UIScene) {
//        playerViewController.appRemoteDisconnect()
//        appRemote.disconnect()
//    }
//
//    func connect() {
//        playerViewController.appRemoteConnecting()
//        appRemote.connect()
//    }
//    
//    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
//        self.appRemote = appRemote
//        playerViewController.appRemoteConnected()
//    }
//    
//    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
//        <#code#>
//    }
//    
//    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
//        <#code#>
//    }
//    
//    var playerViewController: UIViewController {
//        get {
//            let navController = self.window?.rootViewController?.children[0] as! UINavigationController
//            return navController.topViewController as! UIViewController
//        }
//    }
//    
//
//}
