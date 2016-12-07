//
//  facebookButton.swift
//  SocialApp
//
//  Created by RAMIRO AGUIRRE MELENDEZ on 12/7/16.
//  Copyright © 2016 FABATSA. All rights reserved.
//

import UIKit

class facebookButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        //Shadow for the view
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset =  CGSize(width: 1.0, height: 1.0)
        
        //Aspect fit to the background image
//        imageView?.contentMode = .scaleAspectFit
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 2.0
    }

}
