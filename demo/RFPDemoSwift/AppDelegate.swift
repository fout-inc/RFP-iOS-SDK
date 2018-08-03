//
//  AppDelegate.swift
//  RFPDemoSwift
//
//  Created by FreakOut on 2018/07/26.
//  Copyright © 2018年 FreakOut inc.,. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        //==============================
        // RFP Settings
        //==============================

        // Set ad video cache size (default: 100MB)
        //RFP.rfpSetVideoCacheSize(50);

        // Set http timeout(default: 15sec)
        //RFP.rfpSetHttpRequestTimeoutInterval(10.0);

        // Init media
        RFP.rfpInitMedia("3")

        return true
    }

}

