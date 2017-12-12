//
//  MusicItemCell.swift
//  Zealer
//
//  Created by ZJQian on 2017/12/8.
//  Copyright © 2017年 zjq. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage

class MusicItemCell: UITableViewCell {

    @IBOutlet weak var iv_cover: UIImageView!
    @IBOutlet weak var lb_song_name: UILabel!
    @IBOutlet weak var lb_singer_name: UILabel!
    
    
    func setData(json: JSON) {
        
        iv_cover.contentMode = .scaleAspectFill
        iv_cover.clipsToBounds = true
        iv_cover.setRadius(radius: iv_cover.height/2)
        iv_cover.sd_setImage(with: URL.init(string: json["image"].stringValue), placeholderImage: UIImage(named: "placeholder_img"), options: SDWebImageOptions.scaleDownLargeImages, completed: nil)
        lb_song_name.text = json["title"].string
        
        var nameArray = Array<String>()
        
        for str: JSON in json["attrs"]["singer"].arrayValue {
            nameArray.append(str.stringValue)
        }
        let name = nameArray.joined(separator: "/")
        lb_singer_name.text = name
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
