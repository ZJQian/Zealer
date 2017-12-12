//
//  ZLLaunchViewController.swift
//  Zealer
//
//  Created by ZJQian on 2017/12/6.
//  Copyright © 2017年 zjq. All rights reserved.
//

import UIKit
import SDWebImage

class ZLLaunchViewController: ZLBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        let iv_launch = UIImageView.init(frame: CGRect.init(x: 0, y: 80, width: SCREEN_WIDTH, height: 250))
        let data = try? Data.init(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "iPhone-6-Crop", ofType: "gif")!))
        
        let img = UIImage.sd_animatedGIF(with: data)
        iv_launch.image = img
        view.addSubview(iv_launch)
        
        UIView.animate(withDuration: 0.3, delay: 1.5, options: .transitionCrossDissolve, animations: {
            
            iv_launch.alpha = 0.0
        }) { (finish) in
            
            let app = UIApplication.shared.delegate as! AppDelegate
            app.window?.rootViewController = ZLTabBarController()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
