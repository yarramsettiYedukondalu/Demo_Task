//
//  SplashViewController.swift
//  Demo_Task
//
//  Created by ToqSoft on 05/09/24.
//

import UIKit
import Network

class SplashViewController: UIViewController {
    @IBOutlet weak var logo: UIImageView!
    
    let monitor = NWPathMonitor()
    let queue = DispatchQueue.global(qos: .background)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logo.layer.cornerRadius = 40
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(checkInternetConnection), userInfo: nil, repeats: false)
    }
    
    @objc func checkInternetConnection() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    self.transitionToMainViewController()
                }
            } else {
                DispatchQueue.main.async {
                    self.showNoInternetAlert()
                }
            }
        }
        monitor.start(queue: queue)
    }
    
    @objc func transitionToMainViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController {
            UIApplication.shared.windows.first?.rootViewController = mainViewController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }
    
    
}
