//
//  ExpViewController.swift
//  MyApp
//
//  Created by Mateusz Ścigacz on 5/12/17.
//  Copyright © 2017 Mateusz Ścigacz. All rights reserved.
//

import UIKit

class ExpViewController: UIViewController, UICollisionBehaviorDelegate {
    
    @IBOutlet weak var DismissBtn: UIButton!
    
    let data = ["BZ WBK", "Projekty uczelniane", "Swift"]
    let text = ["Stanowisko w Banku Zachodnim WBK otrzymałem dzięki łatwości przyswajania nowych technologii oraz kreatywnemu rozwiązywaniu stawianych problemów. Przez rok pracy w dużej korporacji nauczyłem się sumienności oraz terminowości w wykonywaniu obowiązków. Współpraca z zespołem scrumowym pozwoliła mi zapoznać się z tą metodyką, a także nauczyła działania w większym zespole. Do moich obowiązków należała obsługa narzędzi do tworzenia raportów wynikajacych ze zmiany źródeł danych i potrzeb biznesowych (SPSS Modeler), optymalizacja cyklicznych raportów oraz zasilanie baz danych (SQL,PL/SQL), a także ich zautomatyzowanie w narzędziach analitycznych (Python)."
                ,"W trakcie studiów, w ramach zaliczeń, stworzyłem wiele ciekawych projektów. Każdy z nich pozwolił mi rozwinąć się i zrozumieć dany język programowania. Miałem możliwość wypróbowania wielu technologii: począwszy od prostych aplikacji okienkowych w Delphi/C++, przez gry 2 i 3D napisane w Javie, aż po platformę do tworzenia testów w C# z wykorzystaniem MVVM. W międzyczasie w pomniejszych projektach wykorzystałem Pythona do przetwarzania dźwięku oraz obrazu, a także do napisania detektora przekształconego w interaktywną grę Papier-Kamień-Nożyce. Tematem pracy inżynierskiej był 'Kantor wymiany kryptowalut', którego silnik stworzony został w Javie, baza danych w MySQL, a część kliencka w Ruby on Rails. Pierwszą aplikacją mobilną, którą stworzyłem, był projekt o podstawowej funkcjonalności Endomondo pod Androida. Różnorodność wykorzystanych środowisk, pozwoliła mi na obranie ścieżki własnego rozwoju. Chciałbym tworzyć aplikacje mobilne.",
                "Jest to moja pierwsza aplikacja napisana w tym języku. Ciekawość i chęć poznawania nowych dróg programowania skłania mnie, by po godzinach rozwijać się poprzez internetowe kursy programowania. Motywacja stażem w Allegro zdecydowanie przyspieszyła ten rozwój. Aktualnie jestem w trakcie zgłębiania Swift oraz Elixir. Chciałbym móc wykorzystać swoja wiedzę przy większych projektach oraz zyskać cenne doświadczenie."]
    
    var views = [UIView]()
    var animator:UIDynamicAnimator!
    var gravity:UIGravityBehavior!
    var snap:UISnapBehavior!
    var previousTouchPoint:CGPoint!
    var viewDragging = false
    var viewPinned = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DismissBtn.layer.cornerRadius = DismissBtn.frame.size.width / 2
        
        animator = UIDynamicAnimator(referenceView: self.view)
        gravity = UIGravityBehavior()
        
        animator.addBehavior(gravity)
        gravity.magnitude = 4
        
        var offset:CGFloat = 250
        
        for i in 0 ... data.count - 1 {
            if let view = addViewController(atOffset: offset, dataForVC: data[i] as AnyObject, textForVC: text[i] as AnyObject){
                views.append(view)
                offset -= 50
            } 
        }
    }
    @IBAction func dismissExpVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    func addViewController(atOffset offset:CGFloat, dataForVC data:AnyObject?, textForVC text:AnyObject?) -> UIView?{
        
        let frameForView = self.view.bounds.offsetBy(dx: 0, dy: self.view.bounds.size.height - offset)
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let stackVC = sb.instantiateViewController(withIdentifier: "StackBoard") as! StackViewController
        
        if let view = stackVC.view{
            view.frame = frameForView
            view.layer.cornerRadius = 5
            view.layer.shadowOffset = CGSize(width: 2, height: 2)
            view.layer.shadowColor = UIColor(red: 85.0/255.0, green: 96.0/255.0, blue: 128.0/255.0, alpha: 1.0).cgColor
            view.layer.shadowRadius = 3
            view.layer.shadowOpacity = 0.5
            
            
            if let headingStr = data as? String{
                stackVC.headerString = headingStr
            }
            if let textStr = text as? String{
                stackVC.textString = textStr
            }
            
            self.addChildViewController(stackVC)
            self.view.addSubview(view)
            
            stackVC.didMove(toParentViewController: self)
            
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ExpViewController.handlePan(gestureRecognizer:)))
            view.addGestureRecognizer(panGestureRecognizer)
            
            
            let collision = UICollisionBehavior(items: [view])
            collision.collisionDelegate = self
            animator.addBehavior(collision)
            
            let boundry = view.frame.origin.y + view.frame.size.height
            var boundryStart = CGPoint(x: 0, y: boundry)
            var boundryEnd = CGPoint(x: self.view.bounds.size.width, y: boundry)
            collision.addBoundary(withIdentifier: 1 as NSCopying, from: boundryStart, to: boundryEnd)
            
            
            boundryStart = CGPoint(x: 0, y: 0)
            boundryEnd = CGPoint(x: self.view.bounds.size.width, y:0)
            collision.addBoundary(withIdentifier: 2 as NSCopying, from: boundryStart, to: boundryEnd)
            
            gravity.addItem(view)
            
            let itemBehavior = UIDynamicItemBehavior(items: [view])
            animator.addBehavior(itemBehavior)
      
            return view
            
        }
        
        return nil
    }
    
    func handlePan(gestureRecognizer:UIPanGestureRecognizer){
        
        let touchPoint = gestureRecognizer.location(in: self.view)
        let draggedView = gestureRecognizer.view!
        
        if gestureRecognizer.state == .began{
            let dragStartPoint = gestureRecognizer.location(in: draggedView)
            
            if dragStartPoint.y < 200{
                viewDragging = true
                previousTouchPoint = touchPoint
            }
        }else if gestureRecognizer.state == .changed && viewDragging {
            let yOffset = previousTouchPoint.y - touchPoint.y
            draggedView.center = CGPoint(x: draggedView.center.x, y: draggedView.center.y - yOffset)
            previousTouchPoint = touchPoint
        }else if gestureRecognizer.state == .ended && viewDragging {
            pin(view: draggedView)
            addVelocity(toView: draggedView, fromGestureRecognizer: gestureRecognizer)
            animator.updateItem(usingCurrentState: draggedView)
            viewDragging = false
        }
    }
    
    func pin(view:UIView) {
        
        let viewHasReachedPinLocation = view.frame.origin.y < 100
        
        if viewHasReachedPinLocation{
            if !viewPinned {
                var snapPosition = self.view.center
                snapPosition.y += 30
                snap = UISnapBehavior(item: view, snapTo: snapPosition)
                animator.addBehavior(snap)
                setVisibility(view: view, alpha: 0)
                viewPinned = true
            }
        }else{
            if viewPinned {
                animator.removeBehavior(snap)
                setVisibility(view: view, alpha: 1)
                viewPinned = false
            }
        }
    }
    
    
    func setVisibility(view:UIView, alpha:CGFloat){
        for aView in views {
            if aView != view {
                aView.alpha = alpha
            }
        }
    }
    
    
    func addVelocity(toView view:UIView, fromGestureRecognizer panGesture:UIPanGestureRecognizer){
        var velocity = panGesture.velocity(in: self.view)
        velocity.x = 0
        
        if let behavior = itemBehavior(forView: view){
            behavior.addLinearVelocity(velocity, for: view)
        }
        
    }
    
    func itemBehavior(forView view:UIView) -> UIDynamicItemBehavior?{
        for behavior in animator.behaviors{
            if let itemBehavior = behavior as? UIDynamicItemBehavior{
                if let possibleView = itemBehavior.items.first as? UIView, possibleView == view{
                    return itemBehavior
                }
            }
        }
        return nil
    }
    
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        
        if NSNumber(integerLiteral: 2).isEqual(identifier){
            let view = item as! UIView
            pin(view: view)
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
