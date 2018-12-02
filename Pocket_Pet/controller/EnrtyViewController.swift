//
//  EnrtyViewController.swift
//  Pocket_Pet
//
//  Created by Leiquan Pan on 11/24/18.
//  Copyright © 2018 Leiquan Pan. All rights reserved.
//

import UIKit

class EnrtyViewController: UIViewController {

    @IBOutlet weak var AppIcon: UIImageView!
    
    var animationLabel: PMAnimationLabelView = {
        let label: PMAnimationLabelView = PMAnimationLabelView(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        return label
    } ()
    
    let nameLabel: UILabel = {
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
        label.text = "Pocket Voodoo"
        label.font = UIFont(name: "ArialRoundedMTBold", size: 40)!
        label.textAlignment = .center
        label.textColor = UIColor.white
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        //set app icon image
//        AppIcon.image =
        

        // Do any additional setup after loading the view.
        
        let backImg = UIImage(named: "welcome")
        let background = UIImageView(image: backImg)
        background.frame = self.view.frame
        self.view.addSubview(background)
        self.view.sendSubviewToBack(background)
        animationLabel.text = "Tap To Play"
        animationLabel.font = UIFont(name: "ArialRoundedMTBold", size: 20)!
        animationLabel.textColor = UIColor.white
        animationLabel.center = CGPoint(x: self.view.frame.maxX / 2, y: self.view.frame.maxY * 4 / 5)
        self.view.addSubview(animationLabel)
        animationLabel.startAnimation()
        
        nameLabel.center = CGPoint(x: self.view.frame.maxX / 2, y: self.view.frame.maxY / 3)
        self.view.addSubview(nameLabel)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toARKitView)))
//        tapLabel.enableTogglingFontsOnTap()
    }
    
    @objc func toARKitView() {
        performSegue(withIdentifier: "toARkitView", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
