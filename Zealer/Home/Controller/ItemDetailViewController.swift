//
//  ItemDetailViewController.swift
//  Zealer
//
//  Created by ZJQian on 2017/12/13.
//  Copyright © 2017年 zjq. All rights reserved.
//

import UIKit

class ItemDetailViewController: ZLBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.setViewColor(UIColor.orange.withAlphaComponent(0.0))
    }
    
    override func leftItemAction() {
        
        super.leftItemAction()
        UIView.transition(with: (navigationController?.view)!, duration: 1, options: UIViewAnimationOptions.transitionFlipFromLeft, animations: nil, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
