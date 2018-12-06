import UIKit

@IBDesignable
extension UIImageView
{
    @IBInspectable var setOpenable:Bool {
        get {
            return self.setOpenable
        }
        set(setOpenable) {
            if(setOpenable)
            {
                self.setOpenableImage()
            }
            else
            {
//                for recognizer in self.gestureRecognizers ?? [] {
//                    self.removeGestureRecognizer(recognizer)
//                }
            }
        }
    }
    
    func setOpenableImage()
    {
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(open(sender:)))
        self.addGestureRecognizer(tap)
    }
    
    @objc func open(sender: UIGestureRecognizer)
    {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            if(self.image != nil)
            {
                let vc = JOpenImage()
//                vc.oldFrame = self.frame
                vc.image = self.image!
                
                vc.modalPresentationStyle = .overCurrentContext
                topController.present(vc, animated: false, completion: nil)
            }
        }
    }
}
