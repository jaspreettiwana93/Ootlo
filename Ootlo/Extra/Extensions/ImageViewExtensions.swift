import UIKit
import SDWebImage

extension UIImageView
{
    func setImage(url: String, placeholder: UIImage = UIImage(), indicatorStyle: UIActivityIndicatorViewStyle = .gray, completion: ())
    {
        self.sd_setShowActivityIndicatorView(true)
        self.sd_setIndicatorStyle(indicatorStyle)
//        let stringURL = url.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        if(URL(string: url) != nil)
        {
            self.sd_setImage(with: URL(string: url), placeholderImage: placeholder, completed: { (image, error, cache, _url) in
                completion
            })
        }
        else
        {
            self.image = placeholder
            completion
        }
    }
}
