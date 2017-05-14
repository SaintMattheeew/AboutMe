//
//  MapViewController.swift
//  MyApp
//
//  Created by Mateusz Ścigacz on 5/9/17.
//  Copyright © 2017 Mateusz Ścigacz. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var Map2Label: UILabel!
    @IBOutlet weak var MapLabel: UILabel!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var DismissBtn: UIButton!
    
    var text = "Urodziłem się i całe życie spędziłem w Kościanie. To nieduże miasto niedaleko Poznania. Wywodzą się stąd bracia Jureccy czy 'Papa' Stamm."
    var text2 = "No i wywodzę się ja."
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DismissBtn.layer.cornerRadius = DismissBtn.frame.size.width / 2
        MapLabel.alpha = 0
        Map2Label.alpha = 0
        MapLabel.text = text
        Map2Label.text = text2
        
        
        var location = CLLocationCoordinate2DMake(51.901350, 19.130416)
        var span = MKCoordinateSpanMake(8, 8)
        var region = MKCoordinateRegionMake(location, span)
        let dropPin1 = MKPointAnnotation()
        let dropPin2 = MKPointAnnotation()
        map.layer.cornerRadius = map.frame.size.width / 2
        map.layer.borderWidth = 3
        map.layer.borderColor = DismissBtn.layer.backgroundColor
        map.setRegion(region, animated: true)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)) {
            location = CLLocationCoordinate2DMake(52.078802, 16.638511)
            span = MKCoordinateSpanMake(0.85, 0.85)
            region = MKCoordinateRegionMake(location, span)
            self.map.setRegion(region, animated: true)
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
                dropPin1.coordinate = location
                dropPin1.title = "Kościan"
                dropPin1.subtitle = "Moje rodzinne miasto"
                self.map.addAnnotation(dropPin1)
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                    self.map.selectAnnotation(self.map.annotations[0], animated: true)
                    
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)){
                        self.map.deselectAnnotation(dropPin1, animated: true)
                        self.map.removeAnnotation(dropPin1)
                        location = CLLocationCoordinate2DMake(52.074893, 16.633247)
                        span = MKCoordinateSpanMake(0.05, 0.05)
                        region = MKCoordinateRegionMake(location, span)
                        self.map.setRegion(region, animated: true)
                        UIView.animate(withDuration: 1.3, animations: {() -> Void in
                            self.MapLabel.alpha = 1
                        })
                        
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                            dropPin2.coordinate = location
                            dropPin2.title = "Tutaj mieszkam!"
                            region = MKCoordinateRegionMakeWithDistance(dropPin2.coordinate, 1500, 1500)
                            self.map.setRegion(region, animated: true)
                            
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                                self.map.addAnnotation(dropPin2)
                                
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                                    self.map.selectAnnotation(self.map.annotations[0], animated: true)
                                    
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
                                        self.map.deselectAnnotation(self.map.annotations[0], animated: true)
                                        UIView.animate(withDuration: 1.3, animations: {() -> Void in
                                            
                                            self.Map2Label.alpha = 1
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
    
    
    
    func focusAnimation(dropPin: MKPointAnnotation){
        UIView.animate(withDuration: 1.3, delay: 10, animations: {() -> Void in
            self.map.showAnnotations([dropPin], animated: true)
            
        }, completion: {(_ finished: Bool) -> Void in
            UIView.animate(withDuration: 1.5, delay: 10, animations: {() -> Void in
                self.map.selectAnnotation(self.map.annotations[0], animated: true)
            })
        })
    }

    @IBAction func dismissMapVC(_ sender: Any) {
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
