import Foundation
import UIKit


extension UIApplication {
    class func topViewController(base: UIViewController? = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}


extension UICollectionViewCell {
    func configureCell() {
        self.layer.cornerRadius = 5.0
//        self.layer.borderWidth = 1.0
//        self.layer.borderColor = UIColor.clear.cgColor
//        self.backgroundColor = UIColor.white
//        self.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
}

extension UIView {
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}


extension String
{
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    
    
    
    func validString(charSet : String) -> Bool
    {
        let _charSet = CharacterSet(charactersIn: charSet)
        let set = CharacterSet(charactersIn: self)
        return _charSet.isSuperset(of: set)
    }
    
    func notValidString(charSet : String) -> Bool
    {
        let _charSet = CharacterSet(charactersIn: charSet)
        let set = CharacterSet(charactersIn: self)
        return !_charSet.isSuperset(of: set)
    }
    func alphaNumeric () -> Bool
    {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    func alphabets () -> Bool
    {
        return !isEmpty && range(of: "[^a-zA-Z]", options: .regularExpression) == nil
    }
    func onlyCapitals_Numeric () -> Bool
    {
        
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    
    
    func underLineText(underLineText: String, isBold: Bool, _color: UIColor) -> NSMutableAttributedString
    {
        let _text = NSMutableAttributedString(string: self)
        
        if(isBold)
        {
            let attrs = [NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue,
                         NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16.0),
                         NSAttributedStringKey.foregroundColor : _color] as [NSAttributedStringKey : Any]
            let nsRange = NSString(string: self).range(of: underLineText, options: String.CompareOptions.caseInsensitive)
            
            _text.addAttributes(attrs, range: nsRange)
            
            return _text
        }
        else
        {
            let attrs = [NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue,
                         NSAttributedStringKey.foregroundColor : _color] as [NSAttributedStringKey : Any]
            let nsRange = NSString(string: self).range(of: underLineText, options: String.CompareOptions.caseInsensitive)
            
            _text.addAttributes(attrs, range: nsRange)
            
            return _text
        }
        
    }
    
}

extension UIView {
    func addBorder() {
        self.layer.borderColor = UIColor.appThemeBlue.cgColor
        self.layer.borderWidth = 1.2
        
    }
    func addGrayBorder() {
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1.2
        
    }

    
    
    public func clearBackgroundColor() {
        for view in self.subviews {
            view.backgroundColor = UIColor.clear
            for subview in view.subviews {
                subview.backgroundColor = UIColor.clear
            }
        }
    }
    
   
}
    extension UIViewController {
        func hideKeyboardWhenTappedAround() {
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }
        
        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
    }

extension UIImage {
    var circleMask: UIImage {
        let square = CGSize(width: min(size.width, size.height), height: min(size.width, size.height))
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: square))
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.image = self
        imageView.layer.cornerRadius = square.width/2
        imageView.layer.borderColor = UIColor.appThemeBlue.cgColor
        imageView.layer.borderWidth = 10.0
        imageView.layer.masksToBounds = true
        UIGraphicsBeginImageContext(imageView.bounds.size)
        imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result!
    }
}


extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: newValue!])
        }
    }
}

extension UIView
{
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return self.borderColor
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
}



extension UIImageView: UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    static var picker = UIImagePickerController()
    static let IMAGE_PICKED = "Image_Picked"
    static var type = ""
    
    func imagePicker(vc : UIViewController, message: String)
    {
        UIImageView.type = "s"
        UIImageView.picker.allowsEditing = false
        UIImageView.picker.delegate = self
        
        
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .actionSheet)
        
        let cameraButton = UIAlertAction(title: "Camera", style: .default, handler: { (action) -> Void in
            UIImageView.picker.sourceType = .camera
            vc.present(UIImageView.picker, animated: true, completion: nil)
        })
        
        let  chooseButton = UIAlertAction(title: "Photo Gallery", style: .default, handler: { (action) -> Void in
//            UIImageView.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            UIImageView.picker.sourceType = .photoLibrary
            vc.present(UIImageView.picker, animated: true, completion: nil)
        })
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            //            print("Cancel button tapped")
        })
        
        alertController.addAction(cameraButton)
        alertController.addAction(chooseButton)
        alertController.addAction(cancelButton)
        
        vc.present(alertController, animated: true, completion: nil)
        
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.contentMode = .scaleAspectFill
        
        self.image = UIImage(data: UIImageJPEGRepresentation(chosenImage, 0.5)!, scale: 1.0)
        
        picker.dismiss(animated: false) {
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: UIImageView.IMAGE_PICKED), object: nil, userInfo: nil)
        
    }
    
    
    
}



//**************TEXTVIEW PLACEHOLDER****************//
extension UITextView: UITextViewDelegate {
    
    /// Resize the placeholder when the UITextView bounds change
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }
    
    /// The UITextView placeholder text
    public var placeholder: String? {
        get {
            var placeholderText: String?
            
            if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                placeholderText = placeholderLabel.text
            }
            
            return placeholderText
        }
        set {
            if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
                placeholderLabel.text = newValue
                placeholderLabel.sizeToFit()
            } else {
                self.addPlaceholder(newValue!)
            }
        }
    }
    
    /// When the UITextView did change, show or hide the label based on if the UITextView is empty or not
    ///
    /// - Parameter textView: The UITextView that got updated
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = self.text.count > 0
        }
    }
    
    /// Resize the placeholder UILabel to make sure it's in the same position as the UITextView text
    private func resizePlaceholder() {
        if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
            let labelX = self.textContainer.lineFragmentPadding
            let labelY = self.textContainerInset.top - 2
            let labelWidth = self.frame.width - (labelX * 2)
            let labelHeight = placeholderLabel.frame.height
            
            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
    }
    
    /// Adds a placeholder UILabel to this UITextView
    private func addPlaceholder(_ placeholderText: String) {
        let placeholderLabel = UILabel()
        
        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()
        
        placeholderLabel.font = self.font
        placeholderLabel.textColor = .darkGray
        placeholderLabel.tag = 100
        
        placeholderLabel.isHidden = self.text.count > 0
        
        self.addSubview(placeholderLabel)
        self.resizePlaceholder()
        self.delegate = self
    }
    
}



extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}

extension UIViewController
{
    func scaleAnimation(viw: UIView)
    {
        UIView.animate(withDuration: 0.3, animations: {
            viw.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: { _ in
            UIView.animate(withDuration: 0.3) {
                viw.transform = CGAffineTransform.identity
            }})
    }
    
    func animationToTop_or_Bottom(viw: UIView, isHide: Bool, fromY: CGFloat, toY: CGFloat)
    {
        self.view.layoutIfNeeded()
        if(!isHide)
        {
            viw.isHidden = isHide
        }
        let top = CGRect(x: viw.frame.origin.x, y: toY, width: viw.frame.size.width, height: viw.frame.size.height)
        let tempFrame = CGRect(x: viw.frame.origin.x, y: fromY, width: viw.frame.size.width, height: viw.frame.size.height)
        viw.frame = tempFrame
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
            viw.frame = top
            self.view.layoutIfNeeded()
        }) { (bool) in
            if(isHide)
            {
                viw.isHidden = isHide
            }
        }
    }
    
    func animationToLeft_or_Right(viw: UIView, isHide: Bool, fromX: CGFloat, toX: CGFloat)
    {
        self.view.layoutIfNeeded()
        if(!isHide)
        {
            viw.isHidden = isHide
        }
        let top = CGRect(x: toX, y: viw.frame.origin.y, width: viw.frame.size.width, height: viw.frame.size.height)
        let tempFrame = CGRect(x: fromX, y: viw.frame.origin.y, width: viw.frame.size.width, height: viw.frame.size.height)
        viw.frame = tempFrame
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
            viw.frame = top
            self.view.layoutIfNeeded()
        }) { (bool) in
            if(isHide)
            {
                viw.isHidden = isHide
            }
        }
    }
    
    func isUserLogin() -> Bool
    {
        if(UserDefaults.standard.value(forKey: "login_status") != nil && (UserDefaults.standard.value(forKey: "login_status") as! String) == "1")
        {
            return true
        }
        else
        {
            return false
        }
    }
    
}





extension UIViewController
{
    func getRateWith(value: Int) -> String
    {
        if(value == 1)
        {
            return "★✰✰✰✰"
        }
        else if(value == 2)
        {
            return "★★✰✰✰"
        }
        else if(value == 3)
        {
            return "★★★✰✰"
        }
        else if(value == 4)
        {
            return "★★★★✰"
        }
        else if(value == 5)
        {
            return "★★★★★"
        }
        
        return "✰✰✰✰✰"
    }
}

extension UIViewController
{
    func paginationCollectionView(scrollView: UIScrollView, collView: UICollectionView, maxPage: Int, currentPage: Int, isLoading: Bool, completion: @escaping (Bool) -> ())
    {
        //Bottom Refresh
        if scrollView == collView{
            
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
            {
                if !isLoading{
                    if(currentPage <= maxPage)
                    {
//                        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
//                        spinner.startAnimating()
//                        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
//
//                        tableView.tableFooterView = spinner
//                        tableView.tableFooterView?.isHidden = false
                        
                        let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height)
                        scrollView.setContentOffset(bottomOffset, animated: true)
                        completion(true)
                    }
                    else
                    {
                        completion(false)
//                        let lbl = UILabel()
//                        lbl.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
//                        lbl.text = "Reached at end"
//                        lbl.textAlignment = .center
//                        lbl.textColor = .lightGray
//                        tableView.tableFooterView = lbl
                    }
                    
                }
            }
        }
    }
    
    
    func paginationHorizonCollectionView(scrollView: UIScrollView, collView: UICollectionView, maxPage: Int, currentPage: Int, isLoading: Bool, completion: @escaping (Bool) -> ())
    {
        //Bottom Refresh
        if scrollView == collView{
            
            if ((scrollView.contentOffset.x + scrollView.frame.size.width) >= scrollView.contentSize.width)
            {
                if !isLoading{
                    if(currentPage <= maxPage)
                    {
                        //                        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
                        //                        spinner.startAnimating()
                        //                        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
                        //
                        //                        tableView.tableFooterView = spinner
                        //                        tableView.tableFooterView?.isHidden = false
                        
                        let bottomOffset = CGPoint(x: scrollView.contentSize.width - scrollView.bounds.size.width, y: 0)
                        scrollView.setContentOffset(bottomOffset, animated: true)
                        completion(true)
                    }
                    else
                    {
                        //                        let lbl = UILabel()
                        //                        lbl.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
                        //                        lbl.text = "Reached at end"
                        //                        lbl.textAlignment = .center
                        //                        lbl.textColor = .lightGray
                        //                        tableView.tableFooterView = lbl
                    }
                    
                }
            }
        }
    }
    
    func paginationToScrollView(scrollView: UIScrollView, maxPage: Int, currentPage: Int, isLoading: Bool, completion: @escaping (Bool) -> ())
    {
        if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
        {
            if !isLoading{
                if(currentPage <= maxPage)
                {
                    let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height)
                    scrollView.setContentOffset(bottomOffset, animated: true)
                    completion(true)
                }
                else
                {
                    
                }
            }
        }
    }
    
    
    func paginationTableView(scrollView: UIScrollView, tableView: UITableView, maxPage: Int, currentPage: Int, isLoading: Bool, completion: @escaping (Bool) -> ())
    {
        //Bottom Refresh
        if scrollView == tableView{
            
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
            {
                if !isLoading{
                    if(currentPage <= maxPage)
                    {
                        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
                        spinner.startAnimating()
                        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
                        
                        tableView.tableFooterView = spinner
                        tableView.tableFooterView?.isHidden = false
                        
                        let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height)
                        scrollView.setContentOffset(bottomOffset, animated: true)
                        completion(true)
                    }
                    else
                    {
                        let lbl = UILabel()
                        lbl.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
                        lbl.text = "Reached at end"
                        lbl.textAlignment = .center
                        lbl.textColor = .lightGray
                        tableView.tableFooterView = lbl
                    }
                }
            }
        }
    }
    func dataLoaded(tableView: UITableView)
    {
        if(tableView.tableFooterView is UIActivityIndicatorView)
        {
            let spinner = tableView.tableFooterView as! UIActivityIndicatorView
            spinner.stopAnimating()
            tableView.tableFooterView?.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            spinner.removeFromSuperview()
        }
    }
}

//For optional object where value expected Any type
//i.e Optional("value").toString()
extension Optional where Wrapped == Any
{
    func toString(defaultValue: String = "") -> String
    {
        if("\(self ?? "<null>")" == "<null>")
        {
            return defaultValue
        }
        else
        {
            return "\(self ?? defaultValue)"
        }
    }
//    //For handle string "<null>" from backend
//    func toString(defaultValueForNull: String) -> String
//    {
//        if("\(self ?? NULL)" == NULL)
//        {
//            return defaultValueForNull
//        }
//        else
//        {
//            return "\(self ?? defaultValueForNull)"
//        }
//    }
}


