//
//  SettingView.swift
//  Pocket_Pet
//
//  Created by 林岳 on 11/30/18.
//

import UIKit

class SettingView: UIView{
    
    let hiLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Hi, all"
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name: <#T##String#>, size: <#T##CGFloat#>)
        return label
    } ()
    
    let copyrightLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Copyright © 2018 CSE438 project\n Group(IG No.1)\n All rights reserved"
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 3
        
//        label.center = CGPoint(x: 160, y: 284)
        label.textAlignment = NSTextAlignment.center
        return label
    } ()
    
    let figureImg: UIImageView = {
        let img = UIImage(named: "settingFigure")
        let view = UIImageView(image: img)
        view.frame = CGRect(x: 0, y: 0, width: 192, height: 108)
        return view
    } ()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(copyrightLabel)
        self.addSubview(figureImg)
        self.addSubview(hiLabel)
        print(figureImg)
//        print(self.subviews)
        
    }
    
}
