//
//  EBookDetailVC.swift
//  Ootlo
//
//  Created by Mac on 05/12/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import FolioReaderKit

class EBookDetailVC: UIViewController {
    
    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var imgBookImage: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblViews: UILabel!
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    var selectedIndex = 0
    var type = BooksType.featured
    
    var data: EBook?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initData()
        
    }

    func initData()
    {
        
        if(type == .featured)
        {
            data = Model.FeaturedEBooks[selectedIndex]
        }
        else if(type == .latest)
        {
            data = Model.LatestEBooks[selectedIndex]
        }
        else if(type == .popular)
        {
            data = Model.PopularEBooks[selectedIndex]
        }
        
        if(data != nil)
        {
            imgBookImage.setImage(url: "http://ootlo.com/backend/images/" + (data?.book_bg_img)!, completion: ())
            imgCover.setImage(url: "http://ootlo.com/backend/images/" + (data?.book_cover_img)!, completion: ())
            lblTitle.text = data?.book_title
            lblViews.text = data?.book_views
            lblAuthor.text = data?.author_name
            lblRate.text = UIViewController().getRateWith(value: (data?.rate_avg.toInt())!)
            lblDesc.text = data?.book_description.htmlToString
        }
        else
        {
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    //MARK: Actions
    @IBAction func btnReadAction(_ sender: UIButton) {
        getBookWith(ID: (data?.id)!, completion: {
            
            //The URL to Save
            let yourURL = URL(string: (self.data?.book_file_url)!)
            //Create a URL request
            let urlRequest = URLRequest(url: yourURL!)
            //get the data
            self.downloadWith(request: urlRequest, fileName: (yourURL?.lastPathComponent)!)
            
            
        })
    }
    
}

extension EBookDetailVC
{
    func getBookWith(ID: String, completion: @escaping ()->())
    {
        webservicesPostRequest(method: "api.php?book_id=\(ID)", parameters: NSDictionary(), isIndicator: true, success: { (responseData) in
            
            if(responseData["EBOOK_APP"] is [[String : Any]] && (responseData["EBOOK_APP"] as! [[String : Any]]).count > 0)
            {
                let response = (responseData["EBOOK_APP"] as! [[String : Any]])[0]
                
                self.data?.book_file_url = response["book_file_url"].toString()
                self.data?.book_video_file_type = response["book_video_file_type"].toString()
                self.data?.book_video_file_url = response["book_video_file_url"].toString()
                self.data?.book_youtube_id = response["book_youtube_id"].toString()
                
                if(self.type == .featured)
                {
                    Model.FeaturedEBooks[self.selectedIndex] = (self.data)!
                }
                else if(self.type == .latest)
                {
                    Model.LatestEBooks[self.selectedIndex] = (self.data)!
                }
                else if(self.type == .popular)
                {
                    Model.PopularEBooks[self.selectedIndex] = (self.data)!
                }
                completion()
            }
            else
            {
                self.view.showJToast(_message: "Unable to get ebook from server try again", _bgImage: UIImage(), _bgColor: UIColor.JToastBGColor.errorColor, _textColor: .white, _type: .error)
            }
            
        }) { (error) in
            
        }
    }
    
    func downloadWith(request: URLRequest, fileName: String)
    {
        indicator(true)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                self.indicator(false)
            }
            guard error == nil else {
                print(error!)
                return
            }
            // Success
            if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                print("Success: \(statusCode)")
            }
            
            do {
                let documentFolderURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                let fileURL = documentFolderURL.appendingPathComponent(fileName)
                do{
                    try FileManager.default.removeItem(at: fileURL)
                }
                catch{}
                try data!.write(to: fileURL)
                
                
                var fileLocalPath: String = fileURL.absoluteString.replacingOccurrences(of: "file:///", with: "")
                if(fileLocalPath.hasSuffix("/"))
                {
                    fileLocalPath.remove(at: fileLocalPath.index(before: fileLocalPath.endIndex))
                }
                DispatchQueue.main.async {
                    
//                    let documentController = UIDocumentInteractionController.init(url: fileURL)
//                    documentController.delegate = self
//                    documentController.presentPreview(animated: true)
                    
                    let config = FolioReaderConfig()
                    
                    let folioReader = FolioReader()
                    
                    folioReader.presentReader(parentViewController: self.navigationController!, withEpubPath: fileLocalPath, andConfig: config)
                }
                
            } catch  {
                self.indicator(false)
                print("error writing file \(fileName) : \(error)")
            }
        }
        task.resume()
    }
}

