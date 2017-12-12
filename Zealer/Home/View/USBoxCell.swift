//
//  USBoxCell.swift
//  Zealer
//
//  Created by ZJQian on 2017/12/8.
//  Copyright © 2017年 zjq. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage

class USBoxCell: UITableViewCell {

    @IBOutlet weak var lb_rank: UILabel!
    @IBOutlet weak var iv_cover: UIImageView!
    @IBOutlet weak var lb_name: UILabel!
    @IBOutlet weak var lb_point: UILabel!
    @IBOutlet weak var lb_average: UILabel!
    @IBOutlet weak var lb_director: UILabel!
    @IBOutlet weak var lb_actor: UILabel!
    @IBOutlet weak var lb_money: UILabel!
    @IBOutlet weak var lb_num: UILabel!
    
    
    
    func setData(json: JSON) {
        iv_cover.sd_setImage(with: URL.init(string: json["subject"]["images"]["small"].stringValue), placeholderImage: UIImage(named: "placeholder_img"), options: SDWebImageOptions.scaleDownLargeImages, completed: nil)
        lb_rank.setRadius(radius: lb_rank.height/2)
        lb_rank.text = json["rank"].stringValue
        lb_name.text = json["subject"]["title"].stringValue
        if json["subject"]["rating"]["average"].floatValue == 0.0 {
            
            lb_point.text = "暂无评分"
            lb_point.textColor = UIColor.lightGray
            lb_average.text = ""
        }else{
            lb_point.text = "豆瓣评分:"
            lb_point.textColor = UIColor(hex:"FFC530")
            lb_average.text = String(format: "%.1f",json["subject"]["rating"]["average"].floatValue)
        }
        
        var directorArray = Array<String>()
        for dic: JSON in json["subject"]["directors"].arrayValue {
            directorArray.append(dic["name"].stringValue)
        }
        lb_director.text = "导演: "+directorArray.joined(separator: "/")
        
        
        var castArray = Array<String>()
        for dic: JSON in json["subject"]["casts"].arrayValue {
            castArray.append(dic["name"].stringValue)
        }
        lb_actor.text = castArray.count>0 ? "主演: "+castArray.joined(separator: "/") : ""
        lb_money.text = "票房: $"+json["box"].stringValue
        if json["subject"]["collect_count"].intValue > 9999 {
            let num = json["subject"]["collect_count"].floatValue/10000.0
            lb_num.text = String(format: "%.1f",num)+"万人看过"
            lb_num.textColor = UIColor(hex:"FFC530")
        } else{
            lb_num.text = json["subject"]["collect_count"].stringValue+"人看过"
            lb_num.textColor = UIColor(hex:"EB3460")
        }
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
