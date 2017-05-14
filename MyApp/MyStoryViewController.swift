//
//  MyStoryViewController.swift
//  MyApp
//
//  Created by Mateusz Ścigacz on 5/9/17.
//  Copyright © 2017 Mateusz Ścigacz. All rights reserved.
//

import UIKit

class MyStoryViewController: UIViewController,UIViewControllerTransitioningDelegate {


    @IBOutlet weak var StoryLabel: UILabel!
    
    @IBOutlet weak var ChildhoodBtn: UIButton!

    @IBOutlet weak var DismissBtn: UIButton!
    @IBOutlet weak var MapBtn: UIButton!
    
    @IBOutlet weak var MountainBtn: UIButton!
    
    @IBOutlet weak var FamilyBtn: UIButton!
    
    let transition = CircularTransition()
    var segueId = String()
    
    var counter = 0
    var timer:Timer?
    
    var text = Array("Poznaj kilka faktów\nz mojego życia.".characters)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ChildhoodBtn.layer.cornerRadius = ChildhoodBtn.frame.size.width / 2
        ChildhoodBtn.alpha = 0
        MapBtn.layer.cornerRadius = MapBtn.frame.size.width / 2
        MapBtn.alpha = 0
        MountainBtn.layer.cornerRadius = ChildhoodBtn.frame.size.width / 2
        MountainBtn.alpha = 0
        FamilyBtn.layer.cornerRadius = FamilyBtn.frame.size.width / 2
        FamilyBtn.alpha = 0
        DismissBtn.layer.cornerRadius = DismissBtn.frame.size.width / 2
        
        ChildhoodBtn.tag = 1
        FamilyBtn.tag = 2
        
        fireTimer()
        delay()
    }
    

    @IBAction func dismissMyStoryVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func fireTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(typeLetter), userInfo: nil, repeats: true)
    }
    
    func addPulse(numberPulses: Float, duration: TimeInterval, btn: UIButton){
        let pulse = Pulsing(numberOfPulses: numberPulses, radius: 100, position: btn.center)
        pulse.animationDuration = duration
        pulse.backgroundColor = btn.layer.backgroundColor
        self.view.layer.insertSublayer(pulse, below: btn.layer)
        
    }
    
    func delay(){
    
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(6)) {
        UIView.animate(withDuration: 1.3, animations: {() -> Void in
            self.ChildhoodBtn.alpha = 1
            self.addPulse(numberPulses: 1, duration: 0.4, btn: self.ChildhoodBtn)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            UIView.animate(withDuration: 1.3, animations: {() -> Void in
                self.MapBtn.alpha = 1
                self.addPulse(numberPulses: 1, duration: 0.4, btn: self.MapBtn)
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                UIView.animate(withDuration: 1.3, animations: {() -> Void in
                    self.FamilyBtn.alpha = 1
                    self.addPulse(numberPulses: 1, duration: 0.4, btn: self.FamilyBtn)
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                    UIView.animate(withDuration: 1.3, animations: {() -> Void in
                        self.MountainBtn.alpha = 1
                        self.addPulse(numberPulses: 1, duration: 0.4, btn: self.MountainBtn)
                    })
                }
            }
        }
        }
    }
    
    func typeLetter(){
        if counter < text.count {
            StoryLabel.text = StoryLabel.text! + String(text[counter])
            let randomInterval = Double((arc4random_uniform(8)+1))/30
            timer?.invalidate()
            timer = Timer.scheduledTimer(timeInterval: randomInterval, target: self, selector: #selector(typeLetter), userInfo: nil, repeats: false)
        } else {
            timer?.invalidate()
        }
        counter += 1
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChildhoodSeg"{
            segueId = segue.identifier!
            let childhoodVC = segue.destination as! ChildhoodViewController
            childhoodVC.transitioningDelegate = self
            childhoodVC.modalPresentationStyle = .custom
            childhoodVC.buttonTag = ((sender as AnyObject).tag)!
            
        }
        else if segue.identifier == "MapSeg"{
            segueId = segue.identifier!
            let mapVC = segue.destination as! MapViewController
            mapVC.transitioningDelegate = self
            mapVC.modalPresentationStyle = .custom


        }
        else if segue.identifier == "MountainSeg"{
            segueId = segue.identifier!
            let mountainVC = segue.destination as! MountainViewController
            mountainVC.transitioningDelegate = self
            mountainVC.modalPresentationStyle = .custom
        }
        else if segue.identifier == "FamilySeg"{
            segueId = segue.identifier!
            let familyVC = segue.destination as! ChildhoodViewController
            familyVC.transitioningDelegate = self
            familyVC.modalPresentationStyle = .custom
            familyVC.buttonTag = ((sender as AnyObject).tag)!
        }
        
    }
    
    

    

    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if segueId == "ChildhoodSeg"{
        transition.transitionMode = .dismiss
        transition.startingPoint = ChildhoodBtn.center
        transition.circleColor = ChildhoodBtn.backgroundColor!
        }
        else if segueId == "MapSeg"{
            transition.transitionMode = .dismiss
            transition.startingPoint = MapBtn.center
            transition.circleColor = MapBtn.backgroundColor!
        }
        else if segueId == "MountainSeg"{
            transition.transitionMode = .dismiss
            transition.startingPoint = MountainBtn.center
            transition.circleColor = MountainBtn.backgroundColor!
        }
        else if segueId == "FamilySeg"{
            transition.transitionMode = .dismiss
            transition.startingPoint = FamilyBtn.center
            transition.circleColor = FamilyBtn.backgroundColor!
        }
        return transition
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if segueId == "ChildhoodSeg"{
            transition.transitionMode = .present
            transition.startingPoint = ChildhoodBtn.center
            transition.circleColor = ChildhoodBtn.backgroundColor!
        }
        else if segueId == "MapSeg"{
            transition.transitionMode = .present
            transition.startingPoint = MapBtn.center
            transition.circleColor = MapBtn.backgroundColor!
        }
        else if segueId == "MountainSeg"{
            transition.transitionMode = .present
            transition.startingPoint = MountainBtn.center
            transition.circleColor = MountainBtn.backgroundColor!
        }
        else if segueId == "FamilySeg"{
            transition.transitionMode = .present
            transition.startingPoint = FamilyBtn.center
            transition.circleColor = FamilyBtn.backgroundColor!
        }
        
        return transition
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
