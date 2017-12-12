//
//  HomeItemCell.swift
//  Zealer
//
//  Created by ZJQian on 2017/12/7.
//  Copyright © 2017年 zjq. All rights reserved.
//

import UIKit
import SDWebImage
import SwiftyJSON

class HomeItemCell: UITableViewCell {

    @IBOutlet weak var iv_cover: UIImageView!
    @IBOutlet weak var lb_name: UILabel!
    @IBOutlet weak var lb_point: UILabel!
    @IBOutlet weak var lb_average: UILabel!
    @IBOutlet weak var lb_director: UILabel!
    @IBOutlet weak var lb_actor: UILabel!
    @IBOutlet weak var lb_num: UILabel!
    
    
    func setData(dic: JSON) {
        
        iv_cover.contentMode = .scaleAspectFill
        iv_cover.clipsToBounds = true
        iv_cover.sd_setImage(with: URL.init(string: dic["images"]["small"].stringValue), placeholderImage: UIImage.init(named: "placeholer_img"), options: SDWebImageOptions.scaleDownLargeImages, completed: nil)
        lb_name.text = dic["title"].string
        if dic["rating"]["average"].floatValue == 0.0 {
            
            lb_point.text = "暂无评分"
            lb_point.textColor = UIColor.lightGray
            lb_average.text = ""
        }else{
            lb_point.text = "豆瓣评分:"
            lb_point.textColor = UIColor(hex:"FFC530")
            lb_average.text = String(format: "%.1f",dic["rating"]["average"].floatValue)
        }
        
        var directorArray = Array<String>()
        for json: JSON in dic["directors"].arrayValue {
            directorArray.append(json["name"].stringValue)
        }
        lb_director.text = "导演: "+directorArray.joined(separator: "/")
        
        
        var castArray = Array<String>()
        for json: JSON in dic["casts"].arrayValue {
            castArray.append(json["name"].stringValue)
        }
        lb_actor.text = castArray.count>0 ? "主演: "+castArray.joined(separator: "/") : ""

        lb_num.text = dic["collect_count"].stringValue+"人看过"
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
