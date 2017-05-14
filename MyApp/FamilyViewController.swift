//
//  FamilyViewController.swift
//  MyApp
//
//  Created by Mateusz Ścigacz on 5/10/17.
//  Copyright © 2017 Mateusz Ścigacz. All rights reserved.
//

import UIKit

class FamilyViewController: UIViewController {

    @IBOutlet weak var DismissBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var family = Family.createFamily()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DismissBtn.layer.cornerRadius = DismissBtn.frame.size.width / 2

        // Do any additional setup after loading the view.
    }

    @IBAction func dismissFamilyVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    struct Storyboard {
        static let CellIdentifier = "Family Cell"
    }

}

extension FamilyViewController : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return family.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.CellIdentifier, for: indexPath) as! FamilyCollectionViewCell
        
        cell.family = self.family[indexPath.item]
        
        return cell
    }
}

extension FamilyViewController : UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
        
        
    }
}
