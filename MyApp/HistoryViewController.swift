//
//  HistoryViewController.swift
//  MyApp
//
//  Created by Mateusz Ścigacz on 5/8/17.
//  Copyright © 2017 Mateusz Ścigacz. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var DismissBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DismissBtn.layer.cornerRadius = DismissBtn.frame.size.width / 2

    }
    
    
    @IBOutlet weak var myTypeWriter: UILabel!
    let myText = Array("Hello World !!!".characters)
    var myCounter = 0
    var timer:Timer?
    func fireTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(typeLetter), userInfo: nil, repeats: true)
    }
    
    func typeLetter(){
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

    @IBAction func dismissHistoryVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
