
protocol JNodataDelegate {
    func retryButtonClicked(userData: [String : Any])
}


class JNoDataView: UIView
{
//    var _NoDataBgView = UIView()
    var _noDataIcon = UIImageView()
    var _noDataText = UILabel()
    var _reloadButton = UIButton()
    
    var delegate: JNodataDelegate!
    
    var userData = [String : Any]()
    
    func _setNoDataView(_view: UIView, bgColor: UIColor, textMessage: String, icon: UIImage, textColor: UIColor, isRetryButton: Bool, retryButtonTitle: String)
    {
        _view.isHidden = false
        self.isHidden = false
        self.frame = _view.bounds
        self.backgroundColor = bgColor
        _view.addSubview(self)
        
        _noDataIcon.frame = CGRect(x: 20, y: (self.frame.size.height / 4), width: self.frame.size.width - 40, height: (self.frame.size.height / 3))
        _noDataIcon.contentMode = .scaleAspectFit
        _noDataIcon.image = icon
        self.addSubview(_noDataIcon)
        
        _noDataText.frame = CGRect(x: 30, y: (self.frame.size.height / 4) + (self.frame.size.height / 3) + 15, width: self.frame.size.width - 60, height: 30)
        _noDataText.text = textMessage
        _noDataText.numberOfLines = 1
        _noDataText.textAlignment = .center
        _noDataText.textColor = textColor
        _noDataText.font = _noDataText.font.withSize(20)
        self.addSubview(_noDataText)
        
        if(isRetryButton)
        {
            if(retryButtonTitle == "")
            {
                _reloadButton.setTitle("Retry", for: .normal)
            }
            else
            {
                _reloadButton.setTitle(retryButtonTitle, for: .normal)
            }
            
            _reloadButton.frame = CGRect(x: (self.frame.size.width / 2) - 80, y: (self.frame.size.height / 4) + (self.frame.size.height / 3) + 60, width: 160, height: 30)
            _reloadButton.setTitleColor(.darkGray, for: .normal)
            _reloadButton.addTarget(self, action: #selector(retryButtonAction(sender:)), for: .touchUpInside)
            self.addSubview(_reloadButton)
        }
        
    }
    
    func _hideNoDataView(_view: UIView)
    {
        _view.isHidden = true
        self.isHidden = true
    }
    
//    func _setNoDataView_With_ApiRetryButton(_view: UIView, bgColor: UIColor, textMessage: String, icon: UIImage, textColor: UIColor, _params: [String : String], _method: String)
//    {
//        self._setNoDataView(_view: self, bgColor: bgColor, textMessage: textMessage, icon: icon, textColor: textColor, isRetryButton: true)
//
//    }
    
//    func _setNoDataView_With_ImageApiRetryButton(_view: UIView, bgColor: UIColor, textMessage: String, icon: UIImage, textColor: UIColor, _params: [String : String], _imgParams: [String : UIImage], _method: String)
//    {
//
//    }
    
    @objc func retryButtonAction(sender: UIButton)
    {
        if(delegate != nil)
        {
            delegate.retryButtonClicked(userData: userData)
        }
    }
    
}


extension UIView
{
//    static let _noDataView = JNoDataView()
//    func setNoDataView(bgColor: UIColor, textMessage: String, icon: UIImage, textColor: UIColor, isRetryButton: Bool)
//    {
//        UIView._noDataView._setNoDataView(_view: self, bgColor: bgColor, textMessage: textMessage, icon: icon, textColor: textColor, isRetryButton: isRetryButton, retryButtonTitle: "Retry")
//    }
}
