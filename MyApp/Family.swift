//
//  Family.swift
//  MyApp
//
//  Created by Mateusz Ścigacz on 5/11/17.
//  Copyright © 2017 Mateusz Ścigacz. All rights reserved.
//

import UIKit

class Family{
    
    var title = ""
    var featuredImage: UIImage!
    
    
    init(title: String, featuredImage: UIImage!){
        self.title = title
        self.featuredImage = featuredImage
    }
    
    static func createFamily() -> [Family]{
        return [
            Family(title: "#kuchnia #ekperymenty\n#tradycyjnie&nowocześnie", featuredImage: UIImage(named: "IMG_5043")!),
            Family(title: "#muzyka #gitara #relaks\n#cierpliwość", featuredImage: UIImage(named: "$_86")!),
            Family(title: "#chomik #burrito #nowyprzyjaciel\n#metodagumowejkaczuszki", featuredImage: UIImage(named: "IMG_0815")!),
            Family(title: "#podróżowanie #przygody\n#dookołaświatazdziewczyną", featuredImage: UIImage(named: "IMG_2779")!),
            Family(title: "#siłownia #wyzwania\n#zdrowystylżycia", featuredImage: UIImage(named: "gym")!),
        ]
    }
    
    
    
    
}
