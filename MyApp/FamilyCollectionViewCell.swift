//
//  FamilyCollectionViewCell.swift
//  MyApp
//
//  Created by Mateusz Ścigacz on 5/11/17.
//  Copyright © 2017 Mateusz Ścigacz. All rights reserved.
//

import UIKit

class FamilyCollectionViewCell: UICollectionViewCell {
    
    var family: Family!{
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var familyTitleLabel: UILabel!
   
    private func updateUI(){
        familyTitleLabel?.text! = family.title
        featuredImageView?.image! = family.featuredImage
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor(red: 85.0/255.0, green: 96.0/255.0, blue: 128.0/255.0, alpha: 1.0).cgColor
        self.layer.shadowRadius = 8
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: 8, height: 8)
        self.layer.shadowColor = UIColor(red: 85.0/255.0, green: 96.0/255.0, blue: 128.0/255.0, alpha: 1.0).cgColor
        self.clipsToBounds = false
    }
}
