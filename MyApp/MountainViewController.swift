//
//  MountainViewController.swift
//  MyApp
//
//  Created by Mateusz Ścigacz on 5/10/17.
//  Copyright © 2017 Mateusz Ścigacz. All rights reserved.
//

import UIKit
import CoreMotion

class MountainViewController: UIViewController {

    @IBOutlet weak var Labelka: UILabel!
    @IBOutlet weak var HoryzontyLabel: UILabel!
    @IBOutlet weak var MyFace: UIImageView!
    @IBOutlet weak var BackgroundImage: UIImageView!
    @IBOutlet weak var DismissBtn: UIButton!
    @IBOutlet weak var MountainLabel: UILabel!
    
    var text = "Miłość do gór zaszczepił we mnie ojciec. Zabierał mnie i mojego brata w polskie Tatry. Wspólnymi siłami zdobywaliśmy kolejne szczyty.\n\nKontynuuję tradycję zdobywając słowackie szlaki."
    
    var text2 = "Poszerzam horyzonty."
    var text3 = "Ty tez poszerz swoim iPhonem!"
    
    var motionManager: CMMotionManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        DismissBtn.layer.cornerRadius = DismissBtn.frame.size.width / 2
        
        MountainLabel.text = text
        Labelka.text = text3
        HoryzontyLabel.text = text2
        
        Labelka.alpha = 0
        HoryzontyLabel.alpha = 0
        
        
        applyMotionEffect(toView: BackgroundImage, magnitude: 40)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
        UIView.animate(withDuration: 1.3, animations: {() -> Void in
            self.HoryzontyLabel.alpha = 1
        })
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                UIView.animate(withDuration: 1.3, animations: {() -> Void in
                    self.Labelka.alpha = 1
                }, completion: {(_ finished: Bool) -> Void in
                    UIView.animate(withDuration: 1.5, animations: {() -> Void in
                        self.Labelka.alpha = 0
                    })
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                    UIView.animate(withDuration: 1.3, animations: {() -> Void in
                        self.Labelka.alpha = 1
                    }, completion: {(_ finished: Bool) -> Void in
                        UIView.animate(withDuration: 1.5, animations: {() -> Void in
                            self.Labelka.alpha = 0
                        })
                    })
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                        UIView.animate(withDuration: 1.3, animations: {() -> Void in
                            self.Labelka.alpha = 1})
                
                    }
                }
            }
        }

    }
    
    func applyMotionEffect(toView viw:UIView, magnitude:Float){
        let xMotion = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        xMotion.minimumRelativeValue = -magnitude
        xMotion.maximumRelativeValue = magnitude
        view.addMotionEffect(xMotion)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissMountainVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
