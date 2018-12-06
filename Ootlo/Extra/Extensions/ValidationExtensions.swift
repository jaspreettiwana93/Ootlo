enum ValidationTypes
{
    case notEmpty
    case notLessThan
    case validEmail
    case validMobile
    case validPassword
}

extension String
{
    func validate(view: UIView,
                  values: [ValidationTypes],
                  fieldNameForMessage: String,
                  minValue: Int = 0,
                  passwordErrorMessage: String = "") -> Bool
    {
        
        if(values.contains(.notEmpty))
        {
            if(self.isEmpty)
            {
//                view.showJToast(_message: "Please enter \(fieldNameForMessage)", _bgImage: UIImage(), _bgColor: UIColor.JToastBGColor.errorColor, _textColor: .white, _type: .error)
                return false
            }
        }
        if(values.contains(.notLessThan))
        {
            if(self.count < minValue)
            {
//                view.showJToast(_message: "\(fieldNameForMessage) must be greater than or equal to \(minValue)", _bgImage: UIImage(), _bgColor: UIColor.JToastBGColor.errorColor, _textColor: .white, _type: .error)
                return false
            }
        }
        if(values.contains(.validEmail))
        {
//            if(!self.isValidEmail())
//            {
////                view.showJToast(_message: "Please enter valid email", _bgImage: UIImage(), _bgColor: UIColor.JToastBGColor.errorColor, _textColor: .white, _type: .error)
//                return false
//            }
        }
        if(values.contains(.validMobile))
        {
            if(!self.isValidMobileNo())
            {
//                view.showJToast(_message: "Please enter valid mobile number", _bgImage: UIImage(), _bgColor: UIColor.JToastBGColor.errorColor, _textColor: .white, _type: .error)
                return false
            }
        }
        if(values.contains(.validPassword))
        {
            if(self.count < minValue)
            {
//                view.showJToast(_message: (passwordErrorMessage == "") ? "Password must be greater than or equal to \(minValue) characters" : passwordErrorMessage, _bgImage: UIImage(), _bgColor: UIColor.JToastBGColor.errorColor, _textColor: .white, _type: .error)
                return false
            }
        }
        
        return true
    }
    
//    func isValidEmail() -> Bool {
//        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//
//        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//        return emailTest.evaluate(with: self)
//    }
    func isValidMobileNo() -> Bool {
        
        if(self.count < 10)
        {
            return false
        }
        else if(self.count > 12)
        {
            return false
        }
        else
        {
            return true
        }
    }
    func isValidPassword(minPassword: Int) -> Bool {
        if(self.count < minPassword)
        {
            return false
        }
        else
        {
            return true
        }
    }
}
