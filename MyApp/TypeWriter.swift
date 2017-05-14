//
//  Pulsing.swift
//  MyApp
//
//  Created by Mateusz Ścigacz on 5/8/17.
//  Copyright © 2017 Mateusz Ścigacz. All rights reserved.
//

import UIKit

class Pulsing: CALayer {
    
    var animationGroup = CAAnimationGroup()
    
    var myCounter = 0
    var nextPulseAfter:TimeInterval = 0
 
    func typeLetter(myText: Array<Character>, myTypeWriter: UILabel, ){
        if myCounter < myText.count {
            myTypeWriter.text = myTypeWriter.text! + String(myText[myCounter])
            let randomInterval = Double((arc4random_uniform(8)+1))/20
            timer?.invalidate()
            timer = Timer.scheduledTimer(timeInterval: randomInterval, target: self, selector: #selector(typeLetter), userInfo: nil, repeats: false)
        } else {
            timer?.invalidate()
        }
        myCounter += 1
    }
    
    func fireTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(typeLetter), userInfo: nil, repeats: true)
    }
    
    
}
