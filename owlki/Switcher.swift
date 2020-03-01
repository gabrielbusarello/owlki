//
//  Switcher.swift
//  owlki
//
//  Created by Gabriel Dezan Busarello on 29/02/20.
//  Copyright © 2020 Gabriel Dezan Busarello. All rights reserved.
//

import Foundation
import UIKit

class Switcher {
    
    static func updateRootVC(vcInstance: UIViewController, _ sender: Any){
        let status = UserDefaults.standard.bool(forKey: "status")
        let child = UserDefaults.standard.bool(forKey: "child")
        var rootVC : UIViewController
        

        if (status == true){
            if (child == true) {
                rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "childhome") as! ChallengeViewController;
            } else {
                rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "defaulthome") as! ChidrenViewController;
            }
        } else {
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login") as! ViewController;
        }

//        SceneDelegate.scene(<#T##self: SceneDelegate##SceneDelegate#>)
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.window?.rootViewController = rootVC
        rootVC.navigationItem.setHidesBackButton(true, animated: true)
        vcInstance.view.window?.rootViewController!.show(rootVC, sender: sender);
//        vcInstance.view.window?.rootViewController?.children.
//        for child in vcInstance.view.window?.rootViewController?.children ?? [] {
//            child.
//        }
//        if let child = vcInstance.view.window?.rootViewController?.children {
//            child.navigationController.setNavigationBarHidden(false, animated: true)
//        }
        
    }
    
}
