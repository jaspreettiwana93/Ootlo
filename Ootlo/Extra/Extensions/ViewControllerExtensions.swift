import UIKit

extension UIViewController
{
    func isString_A_Float(string: String) -> Bool {
        return Float(string) != nil
    }
    
    func calculateItemAmount(amount: Float, shippingFees: Float, paypalFeesPercent: Float, proxyeedFeesPercent: Float) -> (paypalAmount: Float, proxyeedFees: Float, profitAmount: Float)
    {
        if(amount > 15)
        {
            var calcAmount = amount
            
            calcAmount = calcAmount - shippingFees
            
            let paypalAmount = (amount/100) * paypalFeesPercent
            calcAmount = calcAmount - paypalAmount
            
            var proxyeedFees = (amount/100) * proxyeedFeesPercent
            if(proxyeedFees < 1)
            {
                proxyeedFees = 1
            }
            calcAmount = calcAmount - proxyeedFees
            let profitAmount = calcAmount
            
            return (paypalAmount, proxyeedFees, profitAmount)
        }
        
        return (0, 0, 0)
    }
    
    func changeStatusBar(color: UIColor, style: UIStatusBarStyle)
    {
        UIApplication.shared.statusBarView?.backgroundColor = color
        UIApplication.shared.statusBarStyle = style
    }
    
    func showAlert(alert: String, message: String)
    {
        let alert = UIAlertController(title: alert, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
