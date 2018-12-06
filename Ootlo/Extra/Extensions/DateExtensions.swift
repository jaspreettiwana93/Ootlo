import UIKit

var _blurView = UIView()
var _viewDatePicker = UIView()
var _datePicker = UIDatePicker()
var _btnOk = UIButton()
var _btnCancel = UIButton()
var _strDateFormat = String()
var vcHeight = UIScreen.main.bounds.size.height


extension String
{
    func toDate(stringFormatter: String) -> Date
    {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = stringFormatter
        dateFormatterGet.timeZone = NSTimeZone.local
        //        let someDate = stringDate.replacingOccurrences(of: ".000000", with: "")
        
        if dateFormatterGet.date(from: self) != nil {
            return dateFormatterGet.date(from: self)!
        } else {
            return Date()
        }
    }
}
extension Date
{
    func toString(stringFormatter: String) -> String
    {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = stringFormatter
        dateFormatterGet.timeZone = NSTimeZone.local
        return dateFormatterGet.string(from: self)
    }
}


enum FormatType
{
    case full
    case short
}
extension Date {
    
    func timeAgoDisplay(type: FormatType = .full) -> String {
        
        let calendar = Calendar.current
        let minuteAgo = calendar.date(byAdding: .minute, value: -1, to: Date())!
        let hourAgo = calendar.date(byAdding: .hour, value: -1, to: Date())!
        let dayAgo = calendar.date(byAdding: .day, value: -1, to: Date())!
        let weekAgo = calendar.date(byAdding: .day, value: -7, to: Date())!
        
        if(type == .full)
        {
            if minuteAgo < self {
                let diff = Calendar.current.dateComponents([.second], from: self, to: Date()).second ?? 0
                return "\(diff) " + "sec ago"
            } else if hourAgo < self {
                let diff = Calendar.current.dateComponents([.minute], from: self, to: Date()).minute ?? 0
                return "\(diff) " + "min ago"
            } else if dayAgo < self {
                let diff = Calendar.current.dateComponents([.hour], from: self, to: Date()).hour ?? 0
                return "\(diff) " + "hrs ago"
            } else if weekAgo < self {
                let diff = Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
                return "\(diff) " + "days ago"
            }
            let diff = Calendar.current.dateComponents([.weekOfYear], from: self, to: Date()).weekOfYear ?? 0
            return "\(diff) " + "weeks ago"
        }
        else
        {
            if minuteAgo < self {
                let diff = Calendar.current.dateComponents([.second], from: self, to: Date()).second ?? 0
                return "\(diff)" + "s"
            } else if hourAgo < self {
                let diff = Calendar.current.dateComponents([.minute], from: self, to: Date()).minute ?? 0
                return "\(diff)" + "m"
            } else if dayAgo < self {
                let diff = Calendar.current.dateComponents([.hour], from: self, to: Date()).hour ?? 0
                return "\(diff)" + "h"
            } else if weekAgo < self {
                let diff = Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
                return "\(diff)" + "d"
            }
            let diff = Calendar.current.dateComponents([.weekOfYear], from: self, to: Date()).weekOfYear ?? 0
            return "\(diff)" + "w"
        }
    }
}

extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the amount of nanoseconds from another date
    func nanoseconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.nanosecond], from: date, to: self).nanosecond ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        if nanoseconds(from: date) > 0 { return "\(nanoseconds(from: date))ns" }
        return ""
    }
}


extension NSObject
{
    
    func showDatePicker(vc: UIViewController, stringDateFromat: String, dateMode: UIDatePickerMode, buttonBG_Color: UIColor = .appThemeBlue, textColor: UIColor = .white)
    {
        vc.view.endEditing(true)
        
        _datePicker.datePickerMode = dateMode
        _strDateFormat = stringDateFromat
        
        _blurView.frame = CGRect(x: 0, y: 0, width: vc.view.frame.size.width, height: vc.view.frame.size.height)
        _viewDatePicker.frame = CGRect(x: 0, y: ((vc.view.frame.size.height) - (vc.view.frame.size.height / 2)), width: vc.view.frame.size.width, height: (vc.view.frame.size.height / 2))
        _btnOk.frame = CGRect(x: 0, y: 0, width: vc.view.frame.size.width / 2, height: 45)
        _btnCancel.frame = CGRect(x: (vc.view.frame.size.width / 2) + 1.5, y: 0, width: vc.view.frame.size.width / 2, height: 45)
        _datePicker.frame = CGRect(x: 0, y: 45, width: vc.view.frame.size.width, height: _viewDatePicker.frame.size.height - 45)
        
        _blurView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        _viewDatePicker.backgroundColor = .white
        _btnOk.backgroundColor = buttonBG_Color
        _btnCancel.backgroundColor = buttonBG_Color
        
        _btnOk.setTitleColor(textColor, for: .normal)
        _btnCancel.setTitleColor(textColor, for: .normal)
        
        _btnOk.setTitle("Ok", for: .normal)
        _btnCancel.setTitle("Cancel", for: .normal)
        
        _viewDatePicker.addSubview(_datePicker)
        _viewDatePicker.addSubview(_btnOk)
        _viewDatePicker.addSubview(_btnCancel)
        
        vc.view.addSubview(_blurView)
        vc.view.addSubview(_viewDatePicker)
        
        
        vcHeight = vc.view.frame.size.height
        __________animationToTop_or_Bottom(viw: _viewDatePicker, isHide: false, fromY: vc.view.frame.size.height, toY: vc.view.frame.size.height - _viewDatePicker.frame.size.height)
        
        
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(_handleTap))
        _blurView.addGestureRecognizer(gestureRecognizer)
        
        _btnOk.addTarget(self, action: #selector(_btnOkAction(sender:)), for: .touchUpInside)
        _btnCancel.addTarget(self, action: #selector(_btnCancelAction(sender:)), for: .touchUpInside)
    }
    
    @objc func _handleTap() {
        //        DispatchQueue.main.async {
        _blurView.removeFromSuperview()
        self.__________animationToTop_or_Bottom(viw: _viewDatePicker, isHide: true, fromY: vcHeight - _viewDatePicker.frame.size.height, toY: UIScreen.main.bounds.height)
        //        }
        _blurView = UIView()
        _viewDatePicker = UIView()
        _datePicker = UIDatePicker()
        _btnOk = UIButton()
        _btnCancel = UIButton()
        _strDateFormat = String()
        vcHeight = UIScreen.main.bounds.size.height
        
    }
    
    @objc func _btnOkAction(sender: UIButton) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = _strDateFormat
        
        if(self is UILabel)
        {
            (self as! UILabel).text = dateFormatter.string(from: _datePicker.date)
        }
        else if(self is UITextField)
        {
            (self as! UITextField).text = dateFormatter.string(from: _datePicker.date)
        }
        else
        {
            let message = "**************//PLEASE USE THIS EXTENSION WITH UILABEL OR UITEXTFIELD//***************"
            print(message)
            fatalError(message)
        }
        
        //        _blurView.removeFromSuperview()
        //        __________animationToTop_or_Bottom(viw: _viewDatePicker, isHide: false, fromY: UIScreen.main.bounds.height - _viewDatePicker.frame.size.height, toY: UIScreen.main.bounds.height)
        _handleTap()
    }
    
    @objc func _btnCancelAction(sender: UIButton) {
        //        _blurView.removeFromSuperview()
        //        __________animationToTop_or_Bottom(viw: _viewDatePicker, isHide: false, fromY: UIScreen.main.bounds.height - _viewDatePicker.frame.size.height, toY: UIScreen.main.bounds.height)
        _handleTap()
    }
    
    //**************************
    func showDatePickerWithMinAndMax(vc: UIViewController, stringDateFromat: String, dateMode: UIDatePickerMode, minDate: Date, maxDate: Date)
    {
        
        _datePicker.minimumDate = minDate
        //        _datePicker.maximumDate = maxDate
        
        self.showDatePicker(vc: vc, stringDateFromat: stringDateFromat, dateMode: dateMode)
    }
    //**************************
    
    //********ANIMATION*********
    func __________animationToTop_or_Bottom(viw: UIView, isHide: Bool, fromY: CGFloat, toY: CGFloat)
    {
        //        if(!isHide)
        //        {
        //            viw.isHidden = isHide
        //        }
        _blurView.layoutIfNeeded()
        _viewDatePicker.layoutIfNeeded()
        
        let top = CGRect(x: viw.frame.origin.x, y: toY, width: viw.frame.size.width, height: viw.frame.size.height)
        let tempFrame = CGRect(x: viw.frame.origin.x, y: fromY, width: viw.frame.size.width, height: viw.frame.size.height)
        viw.frame = tempFrame
        _blurView.layoutIfNeeded()
        _viewDatePicker.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
            viw.frame = top
            _blurView.layoutIfNeeded()
            _viewDatePicker.layoutIfNeeded()
            
        }) { (bool) in
            if(isHide)
            {
                viw.removeFromSuperview()
            }
        }
    }
    //**************************
}




