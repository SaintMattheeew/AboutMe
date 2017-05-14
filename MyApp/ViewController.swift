//
//  ViewController.swift
//  MyApp
//
//  Created by Mateusz Ścigacz on 5/7/17.
//  Copyright © 2017 Mateusz Ścigacz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIViewControllerTransitioningDelegate{

    
    @IBOutlet weak var DragandDropLabel: UILabel!
    @IBOutlet weak var ExpLabel: UILabel!
    @IBOutlet weak var InterestsLabel: UILabel!
    @IBOutlet weak var OmnieLabel: UILabel!
    @IBOutlet weak var Image1: UIImageView!
    @IBOutlet weak var Image2: UIImageView!
    @IBOutlet weak var Image3: UIImageView!
    @IBOutlet weak var AvatarImage: UIImageView!
    @IBOutlet weak var MyTypeWriter: UILabel!
    
  
    let transition = CircularTransition()
    var image1Origin = CGPoint()
    var image2Origin = CGPoint()
    var image3Origin = CGPoint()
    let text = Array("Cześć, jestem Mateusz!\nOpowiem Ci o sobie.".characters)
    var counter = 0
    var timer:Timer?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Image1.layer.cornerRadius = Image1.frame.height/2
        Image1.clipsToBounds = true
        Image1.alpha = 0
        image1Origin = Image1.frame.origin
        
        Image2.layer.cornerRadius = Image2.frame.height/2
        Image2.clipsToBounds = true
        Image2.alpha = 0
        image2Origin = Image2.frame.origin
        
        Image3.layer.cornerRadius = Image3.frame.height/2
        Image3.clipsToBounds = true
        Image3.alpha = 0
        image3Origin = Image3.frame.origin
        
        AvatarImage.layer.cornerRadius = AvatarImage.frame.height/2
        AvatarImage.clipsToBounds = true
        AvatarImage.layer.borderWidth = 3.0
        AvatarImage.layer.borderColor = Image1.layer.backgroundColor
        AvatarImage.isUserInteractionEnabled = true
        AvatarImage.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
        OmnieLabel.text = "Moja historia"
        OmnieLabel.alpha = 0
        InterestsLabel.text = "Zainteresowania"
        InterestsLabel.alpha = 0
        ExpLabel.text = "Doświadczenie"
        ExpLabel.alpha = 0
        DragandDropLabel.text = "Drag'n'drop!"
        DragandDropLabel.alpha = 0
        
        focusAnimation()
        delay()
        fireTimer()
    
    }
    
    func animateLabel(label: UILabel){
        UIView.animate(withDuration: 1.3, animations: {() -> Void in
            label.alpha = 1
        }, completion: {(_ finished: Bool) -> Void in
            UIView.animate(withDuration: 1.5, animations: {() -> Void in
                label.alpha = 0
            })
        })
    }
    
    func delay(){
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(8)) {
            self.animateLabel(label: self.OmnieLabel)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                self.animateLabel(label: self.OmnieLabel)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                    self.animateLabel(label: self.InterestsLabel)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                        self.animateLabel(label: self.InterestsLabel)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                            self.animateLabel(label: self.ExpLabel)
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                                self.animateLabel(label: self.ExpLabel)
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                                    self.animateLabel(label: self.DragandDropLabel)
                                    self.addPulse(numberPulses: 3,duration: 0.6)
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                                        UIView.animate(withDuration: 1.3, animations: {() -> Void in
                                            self.DragandDropLabel.alpha = 1
                                            self.addPulse(numberPulses: 3,duration: 0.6)
                                        })
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func fireTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(typeLetter), userInfo: nil, repeats: true)
    }
    
    func typeLetter(){
        if counter < text.count {
            MyTypeWriter.text = MyTypeWriter.text! + String(text[counter])
            let randomInterval = Double((arc4random_uniform(8)+1))/26
            timer?.invalidate()
            timer = Timer.scheduledTimer(timeInterval: randomInterval, target: self, selector: #selector(typeLetter), userInfo: nil, repeats: false)
        } else {
            timer?.invalidate()
        }
        counter += 1
    }
    
    func addPulse(numberPulses: Float, duration: TimeInterval){
        let pulse = Pulsing(numberOfPulses: numberPulses, radius: 160, position: AvatarImage.center)
        pulse.animationDuration = duration
        pulse.backgroundColor = Image1.layer.backgroundColor
        self.view.layer.insertSublayer(pulse, below: AvatarImage.layer)

    }
    
    
    func focusAnimation(){
        UIView.animate(withDuration: 1.3, animations: {() -> Void in
            self.AvatarImage?.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            
        }, completion: {(_ finished: Bool) -> Void in
            UIView.animate(withDuration: 1.5, animations: {() -> Void in
                self.AvatarImage?.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.Image1.alpha = 1
                self.Image1.frame.origin = self.image1Origin
                self.Image2.alpha = 1
                self.Image2.frame.origin = self.image2Origin
                self.Image3.alpha = 1
                self.Image3.frame.origin = self.image3Origin
            })
        })
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in (touches ){
            let location = touch.location(in: self.view)
            
            if Image1.frame.contains(location){
                Image1.center = location
                addPulse(numberPulses: 3,duration: 0.6)
                UIView.animate(withDuration: 1.3, animations: {() -> Void in
                    self.DragandDropLabel.text = "Opowiedz swoja historię!"
                    self.DragandDropLabel.alpha = 0
                }, completion: {(_ finished: Bool) -> Void in
                    UIView.animate(withDuration: 1.5, animations: {() -> Void in
                        self.DragandDropLabel.alpha = 1
                    })
                })
                
            }
            else if Image2.frame.contains(location){
                Image2.center = location
                addPulse(numberPulses: 3,duration: 0.6)
                UIView.animate(withDuration: 1.3, animations: {() -> Void in
                    self.DragandDropLabel.text = "Opowiedz o zainteresowaniach!"
                    self.DragandDropLabel.alpha = 0
                }, completion: {(_ finished: Bool) -> Void in
                    UIView.animate(withDuration: 1.5, animations: {() -> Void in
                        self.DragandDropLabel.alpha = 1
                    })
                })
            }
            else if Image3.frame.contains(location){
                Image3.center = location
                addPulse(numberPulses: 3,duration: 0.6)
                UIView.animate(withDuration: 1.3, animations: {() -> Void in
                    self.DragandDropLabel.text = "Opowiedz o doświadczeniu!"
                    self.DragandDropLabel.alpha = 0
                }, completion: {(_ finished: Bool) -> Void in
                    UIView.animate(withDuration: 1.5, animations: {() -> Void in
                        self.DragandDropLabel.alpha = 1
                    })
                })
            }
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in (touches ){
            let location = touch.location(in: self.view)
            
            if Image1.frame.contains(location){
                Image1.center = location
            }
            else if Image2.frame.contains(location){
                Image2.center = location
            }
            else if Image3.frame.contains(location){
                Image3.center = location
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for touch in (touches ){
            let location = touch.location(in: self.view)
            
            if Image1.frame.contains(location){
                
                if AvatarImage.frame.contains(Image1.center){
                    Image1.alpha = 0
                    UIView.animate(withDuration: 1.3, animations: {() -> Void in
                        self.AvatarImage?.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                        self.Image2.alpha = 0
                        self.Image3.alpha = 0
                        self.DragandDropLabel.alpha = 0
                        self.MyTypeWriter.alpha = 0
                    }, completion: {(_ finished: Bool) -> Void in
                        UIView.animate(withDuration: 0, animations: {() -> Void in
                            self.performSegue(withIdentifier: "MyStorySeg", sender: nil)
                            self.comeBack()
                        })
                    })
                }else{
                    self.Image1.frame.origin = image1Origin
                    UIView.animate(withDuration: 1.3, animations: {() -> Void in
                        self.DragandDropLabel.text = "Drag'n'drop!"
                        self.DragandDropLabel.alpha = 0
                    }, completion: {(_ finished: Bool) -> Void in
                        UIView.animate(withDuration: 1.5, animations: {() -> Void in
                            self.DragandDropLabel.alpha = 1
                        })
                    })
                }
            }
            else if Image2.frame.contains(location){
                Image2.center = location
                if AvatarImage.frame.contains(Image2.center){
                    Image2.alpha = 0
                    UIView.animate(withDuration: 1.3, animations: {() -> Void in
                        self.AvatarImage?.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                        self.Image1.alpha = 0
                        self.Image3.alpha = 0
                        self.DragandDropLabel.alpha = 0
                        self.MyTypeWriter.alpha = 0
                    }, completion: {(_ finished: Bool) -> Void in
                        UIView.animate(withDuration: 0, animations: {() -> Void in
                            self.performSegue(withIdentifier: "FamilySeg", sender: nil)
                            self.comeBack()
                        })
                    })
                }else{
                    self.Image2.frame.origin = image2Origin
                    UIView.animate(withDuration: 1.3, animations: {() -> Void in
                        self.DragandDropLabel.text = "Drag'n'drop!"
                        self.DragandDropLabel.alpha = 0
                    }, completion: {(_ finished: Bool) -> Void in
                        UIView.animate(withDuration: 1.5, animations: {() -> Void in
                            self.DragandDropLabel.alpha = 1
                        })
                    })
                }
            }
            else if Image3.frame.contains(location){
                Image3.center = location
                if AvatarImage.frame.contains(Image3.center){
                    Image3.alpha = 0
                    UIView.animate(withDuration: 1.3, animations: {() -> Void in
                        self.AvatarImage?.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                        self.Image1.alpha = 0
                        self.Image2.alpha = 0
                        self.DragandDropLabel.alpha = 0
                        self.MyTypeWriter.alpha = 0
                    }, completion: {(_ finished: Bool) -> Void in
                        UIView.animate(withDuration: 0, animations: {() -> Void in
                            self.comeBack()
                            self.performSegue(withIdentifier: "ExpSeg", sender: nil)
                        })
                    })
                }else{
                    self.Image3.frame.origin = image3Origin
                    UIView.animate(withDuration: 1.3, animations: {() -> Void in
                        self.DragandDropLabel.text = "Drag'n'drop!"
                        self.DragandDropLabel.alpha = 0
                    }, completion: {(_ finished: Bool) -> Void in
                        UIView.animate(withDuration: 1.5, animations: {() -> Void in
                            self.DragandDropLabel.alpha = 1
                        })
                    })
                }
            }
        }
    }
    

    func comeBack(){
        self.focusAnimation()
        self.DragandDropLabel.alpha = 1
        self.DragandDropLabel.text = "Drag'n'drop!"
        self.MyTypeWriter.alpha = 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

