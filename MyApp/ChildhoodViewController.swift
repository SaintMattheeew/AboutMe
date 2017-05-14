//
//  ChildhoodViewController.swift
//  MyApp
//
//  Created by Mateusz Ścigacz on 5/9/17.
//  Copyright © 2017 Mateusz Ścigacz. All rights reserved.
//

import UIKit

class ChildhoodViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var storyLabel: UILabel!
    @IBOutlet weak var FotoPageControl: UIPageControl!
    @IBOutlet weak var DismissBtn: UIButton!
    @IBOutlet weak var FotoScrollView: UIScrollView!
    
    var imageArray1 = [UIImage]()
    var imageArray2 = [UIImage]()
    
    var buttonTag = 0
    
    var text1 = "Urodziłem się 24 września '94, jako syn pierworodny. Mam młodszego brata, który mimo kilometrów ma we mnie oparcie."
    
    var text2 = "Moim wielkim marzeniem w dzieciństwie, był pies - sznaucer.\nOdważny i wierny. Szary olbrzym z gęstą, przyciętą brodą!\n\nRodzice zlitowali się nade mną i dostałem Borysa, pluszowego szczeniaka. Mam go do dziś."
    
    var text3 = "W liceum obrałem profil matematyczno-fizyczny. Przedmioty ścisłe nigdy nie sprawiały mi problemów, co poskutkowało dobrze zdaną maturą."
    
    var text4 = "Wybór studiów nie był uwarunkowany fascynacją programowaniem. Ta przyszła z czasem spędzonym przy projektach oraz zaowocowała tytułem inżyniera.\n\nNie żałuję tego wyboru!"
    
    var text5 = "Mimo iż jestem osobą młodą z niedużym stażem zawodowym, poznałem wiele języków programowania w trakcie studiów, które wykorzystane zostały w projektach zaliczeniowych."
    
    var text6 = "Na uczelni zaczerpnąłem wiedzę z zakresu aplikacji webowych oraz dobrych praktyk inżynierii oprogramowania. Specjalność, którą obrałem na studiach magisterskich opiera się w dużej mierze na technologiach internetowych oraz mobilnych."

   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        DismissBtn.layer.cornerRadius = DismissBtn.frame.size.width / 2
        
        
        if buttonTag == 1{
            storyLabel.text = text1
            imageArray1 = [#imageLiteral(resourceName: "471180_367614189984700_1218705769_o"), #imageLiteral(resourceName: "IMG_5340"), #imageLiteral(resourceName: "430867_401790866567032_1918113984_n")]
            
            for i in 0..<imageArray1.count {
            
            
                let imageView = UIImageView()
                imageView.image = imageArray1[i]
                imageView.contentMode = .scaleToFill
                let xPosition = FotoScrollView.frame.width * CGFloat(i)
                imageView.frame = CGRect(x: xPosition, y: FotoScrollView.frame.origin.y, width: FotoScrollView.frame.width, height: FotoScrollView.frame.height)

                FotoScrollView.isPagingEnabled = true
                FotoScrollView.contentSize.width = FotoScrollView.frame.width * CGFloat(i + 1)
                FotoScrollView.addSubview(imageView)
                FotoScrollView.showsHorizontalScrollIndicator = false
                FotoScrollView.delegate = self
            }
        } else if buttonTag == 2{
            storyLabel.text = text4
            imageArray2 = [#imageLiteral(resourceName: "IMG_5350"), #imageLiteral(resourceName: "hello-world-program_0"), #imageLiteral(resourceName: "01-bticw_")]
            
            for i in 0..<imageArray2.count {
                
                
                let imageView = UIImageView()
                imageView.image = imageArray2[i]
                imageView.contentMode = .scaleToFill
                let xPosition = FotoScrollView.frame.width * CGFloat(i)
                imageView.frame = CGRect(x: xPosition, y: FotoScrollView.frame.origin.y, width: FotoScrollView.frame.width, height: FotoScrollView.frame.height)
                
                FotoScrollView.isPagingEnabled = true
                FotoScrollView.contentSize.width = FotoScrollView.frame.width * CGFloat(i + 1)
                FotoScrollView.addSubview(imageView)
                FotoScrollView.showsHorizontalScrollIndicator = false
                FotoScrollView.delegate = self
            }
        }
    }
    
    @IBAction func dismissChildhoodVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
        FotoPageControl.currentPage = Int(page)
        updatePageControl()
    }
    
    
    func updatePageControl() {
        for (index, dot) in FotoPageControl.subviews.enumerated() {
            if index == FotoPageControl.currentPage {
                if buttonTag == 1{
                    if index == 0{
                        self.storyLabel.text = text1
                    }else if index == 1{
                        self.storyLabel.text = text2
                    }else if index == 2{
                        self.storyLabel.text = text3
                    }
                }else if buttonTag == 2{
                    if index == 0{
                        self.storyLabel.text = text4
                    }else if index == 1{
                        self.storyLabel.text = text5
                    }else if index == 2{
                        self.storyLabel.text = text6
                    }
                }
                
                dot.backgroundColor = DismissBtn.backgroundColor
                dot.layer.cornerRadius = dot.frame.size.height / 2;
            } else {
                dot.backgroundColor = UIColor.clear
                dot.layer.cornerRadius = dot.frame.size.height / 2
                dot.layer.borderColor = DismissBtn.backgroundColor?.cgColor
                dot.layer.borderWidth = 1.0
            }
        }
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
