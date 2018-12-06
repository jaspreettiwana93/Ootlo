import UIKit

enum JToastType : String {
    case error = "_error"
    case warning = "_warning"
    case success = "_success"
}

extension UIColor {
    
    struct JToastBGColor {
        static var errorColor: UIColor  { return UIColor(red: 200.0/255.0, green: 16.0/255.0, blue: 46.0/255.0, alpha: 1.0) }
        static var warningColor: UIColor { return UIColor(red: 255.0/255.0, green: 165.0/255.0, blue: 0.0/255.0, alpha: 1.0) }
        static var successColor: UIColor { return UIColor(red: 60.0/255.0, green: 180.0/255.0, blue: 113.0/255.0, alpha: 1.0) }
    }
    
//    struct JToastTextColor {
//        static var errorColor: UIColor  { return UIColor(red: 200.0/255.0, green: 16.0/255.0, blue: 46.0/255.0, alpha: 1.0) }
//        static var warningColor: UIColor { return UIColor(red: 255.0/255.0, green: 165.0/255.0, blue: 0.0/255.0, alpha: 1.0) }
//        static var successColor: UIColor { return UIColor(red: 60.0/255.0, green: 180.0/255.0, blue: 113.0/255.0, alpha: 1.0) }
//    }
    
}

class JToast: NSObject {
    var _bgView = UIView()
    var _bgImageView = UIImageView()
    var _icon = UIImageView()
    var _text = UILabel()
    
    var _timer = Timer()
    
    
    
    func _showJToast(_view: UIView, _bgImage: UIImage, _message: String, _bgColor: UIColor, _textColor: UIColor, _type: JToastType)
    {
        _bgView.isUserInteractionEnabled = false
        if(_timer.isValid)
        {
            _timer.invalidate()
        }
        
        if(UIScreen.main.nativeBounds.height == 2436)
        {
            _text.frame = CGRect(x: 50, y: 22 + 30, width: _view.frame.size.width - 60, height: 0)
        }
        else
        {
            _text.frame = CGRect(x: 50, y: 22, width: _view.frame.size.width - 60, height: 0)
        }
            
        if(_message == "")
        {
            _text.text = "<Empty>"
        }
        else
        {
            _text.text = _message
        }
        _text.numberOfLines = 3
        _text.sizeToFit()
        _text.lineBreakMode = .byWordWrapping
        _text.textColor = _textColor
        
//        if UIDevice().userInterfaceIdiom == .phone {
            if(UIScreen.main.nativeBounds.height == 2436)
            {
                _bgView.frame = CGRect(x: 0, y: 0 - (_text.frame.size.height + 10 + 40), width: _view.frame.size.width, height: _text.frame.size.height + 40)
                _bgImageView.frame = CGRect(x: 0, y: 0, width: _view.frame.size.width, height: _text.frame.size.height + 30 + 40)
                _icon.frame = CGRect(x: 5, y: 22 + 30, width: 40, height: _bgView.frame.size.height - 40)
            }
            else
            {
                _bgView.frame = CGRect(x: 0, y: 0 - (_text.frame.size.height + 10), width: _view.frame.size.width, height: _text.frame.size.height + 27)
                _bgImageView.frame = CGRect(x: 0, y: 0, width: _view.frame.size.width, height: _text.frame.size.height + 27)
                _icon.frame = CGRect(x: 5, y: 22, width: 40, height: _bgView.frame.size.height - 27)
            }
//        }
        
        _bgView.backgroundColor = _bgColor.withAlphaComponent(1.0)
        
//        _bgView.frame = CGRect(x: 0, y: 0 - (_text.frame.size.height + 10), width: _view.frame.size.width, height: _text.frame.size.height + 27)
//        _bgView.backgroundColor = _bgColor.withAlphaComponent(0.8)
//        _bgImageView.frame = CGRect(x: 0, y: 0, width: _view.frame.size.width, height: _text.frame.size.height + 27)
        
        _bgImageView.image = _bgImage
        _bgImageView.contentMode = .scaleToFill
        
        
        
//        _icon.frame = CGRect(x: 5, y: 22, width: 40, height: _bgView.frame.size.height - 27)
        _icon.image = UIImage(named: _type.rawValue)
        _icon.contentMode = .scaleAspectFit
        _icon.image = _icon.image?.tinted(with: _textColor)
        
        if !_text.isDescendant(of: _bgView) {
            _bgView.addSubview(_bgImageView)
            _bgView.addSubview(_text)
            _bgView.addSubview(_icon)
        }
        if !_bgView.isDescendant(of: _view) {
            _view.addSubview(_bgView)
        }
        
        UIView.animate(withDuration: 0.2) {
            if(UIScreen.main.nativeBounds.height == 2436)
            {
                self._bgView.frame = CGRect(x: 0, y: (-5) + 10 + 40, width: _view.frame.size.width, height: self._text.frame.size.height + 27 + 40)
            }
            else
            {
                self._bgView.frame = CGRect(x: 0, y: (-5) + 10 + 40, width: _view.frame.size.width, height: self._text.frame.size.height + 27)
            }
        }
        
        let _userInfo = ["superview": _view]
        _timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(_hideJToast(timer:)), userInfo: _userInfo, repeats: true)
    }
    
    @objc func _hideJToast(timer: Timer)
    {
        UIView.animate(withDuration: 0.2, animations: {
            if(timer.userInfo != nil && (timer.userInfo as! [String: Any])["superview"] != nil)
            {
                if((timer.userInfo as! [String: Any])["superview"] is UIView)
                {
                    self._bgView.frame = CGRect(x: 0, y: 0 - (self._text.frame.size.height + 10), width: self._bgView.frame.size.width, height: self._text.frame.size.height + 27)
                }
            }
            
        }) { (bool) in
            if self._text.isDescendant(of: self._bgView) {
                self._text.removeFromSuperview()
                self._icon.removeFromSuperview()
            }
            
            if(timer.isValid && timer.userInfo != nil && (timer.userInfo as! [String: Any])["superview"] != nil)
            {
                if((timer.userInfo as! [String: Any])["superview"] is UIView)
                {
                    let _view = (timer.userInfo as! [String: Any])["superview"] as! UIView
                    if self._bgView.isDescendant(of: _view) {
                        self._bgView.removeFromSuperview()
                    }
                }
            }
        }
    }
}

extension UIView
{
    static let _toast = JToast()
    func showJToast(_message: String, _bgImage: UIImage, _bgColor: UIColor, _textColor: UIColor, _type: JToastType)
    {
        UIView._toast._showJToast(_view: self,_bgImage: _bgImage, _message: _message, _bgColor: _bgColor, _textColor: _textColor, _type: _type)
    }
}

extension UIImage {
    func tinted(with color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        color.set()
        withRenderingMode(.alwaysTemplate)
            .draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
