//
//  StackViewController.swift
//  MyApp
//
//  Created by Mateusz Ścigacz on 5/13/17.
//  Copyright © 2017 Mateusz Ścigacz. All rights reserved.
//

import UIKit

class StackViewController: UIViewController {

    @IBOutlet weak var HeaderLabel: UILabel!
    @IBOutlet weak var TextView: UITextView!
    
    var headerString:String?{
        didSet {
            configureView()
        }
    }
    
    var textString:String?{
        didSet {
            configureView()
        }
    }
    
    func configureView(){
        HeaderLabel.text = headerString
        TextView.text = textString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
