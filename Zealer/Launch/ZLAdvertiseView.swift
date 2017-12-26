//
//  ZLAdvertiseView.swift
//  Zealer
//
//  Created by ZJQian on 2017/12/23.
//  Copyright © 2017年 zjq. All rights reserved.
//

import UIKit

class ZLAdvertiseView: UIView {

    override init(frame: CGRect) {
    
        super.init(frame: frame)
        let img = UIImageView()
        img.frame = self.bounds
        addSubview(img)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        self.frame = UIScreen.main.bounds
    }

}
