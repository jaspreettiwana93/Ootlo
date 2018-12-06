import UIKit

extension UIView{
    func showView(animated:Bool){
        self.alpha = 0
        self.center = CGPoint(x: self.center.x, y: self.frame.height + self.frame.height/2)
        UIApplication.shared.delegate?.window??.rootViewController?.view.addSubview(self)
        if animated {
            UIView.animate(withDuration: 0.33, animations: {
                self.alpha = 0.66
            })
            UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: {
                self.center  = self.center
            }, completion: { (completed) in
                
            })
        }else{
            self.alpha = 0.66
//            self.center  = self.center
        }
    }
    
    func dismissView(animated:Bool){
        if animated {
            UIView.animate(withDuration: 0.33, animations: {
                self.alpha = 0
            }, completion: { (completed) in
                
            })
            UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: {
                self.center = CGPoint(x: self.center.x, y: self.frame.height + self.frame.height/2)
            }, completion: { (completed) in
                self.removeFromSuperview()
            })
        }else{
            self.removeFromSuperview()
        }
        
    }
}

extension UIViewController
{
    func openSideBar()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.sideMenuController.showLeftView(animated: true, completionHandler: nil)
    }
    
    func isEnableSideMenu(bool: Bool)
    {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.sideMenuController.isLeftViewSwipeGestureEnabled = bool
    }
    
    @objc func openSideMenu()
    {
        openSideBar()
    }
}
