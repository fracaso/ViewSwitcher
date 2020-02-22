

import UIKit

class SwitchingViewController: UIViewController {
    
    private var blueViewController: BlueViewController!
    private var yellowViewController: YellowViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blueViewController = (storyboard?.instantiateViewController(withIdentifier: "Blue") as! BlueViewController)
        blueViewController.view.frame = view.frame
        switchViewController(from: nil, to: blueViewController)
    }
    
    @IBAction func switchViews(sender: UIBarButtonItem) {
        // Create the new view controller, if required
        if yellowViewController?.view.superview == nil {
            if yellowViewController == nil {
                yellowViewController = (storyboard?.instantiateViewController(withIdentifier: "Yellow") as! YellowViewController)
            }
        } else if blueViewController?.view.superview == nil {
            if blueViewController == nil {
                blueViewController = (storyboard?.instantiateViewController(withIdentifier: "Blue") as! BlueViewController)
            }
        }

        UIView.beginAnimations("View Flip", context:nil)
        UIView.setAnimationDuration(1.0)
        UIView.setAnimationCurve(.easeInOut)
        
    // Switch view controllers
        if blueViewController != nil && blueViewController!.view.superview != nil {
            UIView.setAnimationTransition(.flipFromRight, for: view, cache: true)
            yellowViewController.view.frame = view.frame
            switchViewController(from: blueViewController, to: yellowViewController)
        } else {
            UIView.setAnimationTransition(.flipFromRight, for: view, cache: true)
            blueViewController.view.frame = view.frame
            switchViewController(from: yellowViewController, to: blueViewController)
        }

        UIView.commitAnimations()
        
    }
    
    // Memory management
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        if blueViewController != nil && blueViewController!.view.superview == nil {
            blueViewController = nil
        }
        if yellowViewController != nil && yellowViewController!.view.superview == nil {
            yellowViewController = nil
        }
    }
    
    private func switchViewController(from fromVC:UIViewController?, to toVC:UIViewController?) {
        if fromVC != nil {
            fromVC!.willMove(toParent: nil)
            fromVC!.view.removeFromSuperview()
            fromVC!.removeFromParent()
        }
        
        if toVC != nil {
            self.addChild(toVC!)
            
            // at 0 Keeps Toolbar in front
            self.view.insertSubview(toVC!.view, at: 0)
            toVC!.didMove(toParent: self)
        }
    }

}
