//
//  EBooksVC.swift
//  Ootlo
//
//  Created by Mac on 05/12/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

enum BooksType
{
    case latest
    case featured
    case popular
}

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableViewHome: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home"
        
        tableViewHome.delegate = self
        tableViewHome.dataSource = self
        tableViewHome.tableFooterView = UIView()
        
        getEbooks()
        setupNav()
    }
    
    func setupNav()
    {
        let btnMenu = UIButton(type: .custom)
        btnMenu.setImage(UIImage(named: "list-icon"), for: .normal)
        btnMenu.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnMenu.addTarget(self, action: #selector(openSideMenu), for: .touchUpInside)
        let itemMenu = UIBarButtonItem(customView: btnMenu)
        self.navigationItem.setLeftBarButton(itemMenu, animated: false)
    }
    
}


extension HomeVC
{
    //MARK: TableView delegates and datasources
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 30))
        headerView.backgroundColor = .lightGray
        let lblTitle = UILabel(frame: headerView.bounds)
        if(section == 0)
        {
            lblTitle.text = "   Featured EBooks"
        }
        else if(section == 1)
        {
            lblTitle.text = "   Popular EBooks"
        }
        else
        {
            lblTitle.text = "   Latest EBooks"
        }
        headerView.addSubview(lblTitle)
        
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0)
        {
            return Model.FeaturedEBooks.count
        }
        else if(section == 1)
        {
            return Model.PopularEBooks.count
        }
        else
        {
            return Model.LatestEBooks.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! EBookCell
        if(indexPath.section == 0)
        {
            cell.initData(indexPath: indexPath, type: .featured)
        }
        else if(indexPath.section == 1)
        {
            cell.initData(indexPath: indexPath, type: .popular)
        }
        else
        {
            cell.initData(indexPath: indexPath, type: .latest)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "EBookDetailVC") as! EBookDetailVC
        if(indexPath.section == 0)
        {
            vc.type = .featured
        }
        else if(indexPath.section == 1)
        {
            vc.type = .popular
        }
        else
        {
            vc.type = .latest
        }
        vc.selectedIndex = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: Apis
    func getEbooks()
    {
        webservicesPostRequest(method: "api.php?home", parameters: NSDictionary(), isIndicator: true, success: { (response) in
            if response["EBOOK_APP"] is [String : Any]
            {
                self.handleEbooksData(data: response["EBOOK_APP"] as! [String : Any])
            }
            else
            {
                self.view.showJToast(_message: "Unable to get ebooks from server try again", _bgImage: UIImage(), _bgColor: UIColor.JToastBGColor.errorColor, _textColor: .white, _type: .error)
            }
            
        }) { (error) in
//            self.view.showJToast(_message: response.value(forKey: "message").toString(defaultValue: ERROR_UNKNOWN), _bgImage: UIImage(), _bgColor: UIColor.JToastBGColor.errorColor, _textColor: .white, _type: .error)
        }
    }
    
    func handleEbooksData(data: [String : Any])
    {
        Model.FeaturedEBooks.removeAll()
        Model.LatestEBooks.removeAll()
        Model.PopularEBooks.removeAll()
        
        if(data["featured_books"] is [[String : Any]])
        {
            for ebook in data["featured_books"] as! [[String : Any]]
            {
                let book = EBook(aid: ebook["aid"].toString(),
                                 author_id: ebook["author_id"].toString(),
                                 author_name: ebook["author_name"].toString(),
                                 book_bg_img: ebook["book_bg_img"].toString(),
                                 book_cover_img: ebook["book_cover_img"].toString(),
                                 book_file_type: ebook["book_file_type"].toString(),
                                 book_title: ebook["book_title"].toString(),
                                 book_views: ebook["book_views"].toString(),
                                 cat_id: ebook["cat_id"].toString(),
                                 category_name: ebook["category_name"].toString(),
                                 cid: ebook["cid"].toString(),
                                 id: ebook["id"].toString(),
                                 rate_avg: ebook["rate_avg"].toString(),
                                 total_rate: ebook["total_rate"].toString(),
                                 book_description: ebook["book_description"].toString(),
                                 book_file_url: String(),
                                 book_video_file_type: String(),
                                 book_video_file_url: String(),
                                 book_youtube_id: String())
                Model.FeaturedEBooks.append(book)
            }
        }
        if(data["latest_books"] is [[String : Any]])
        {
            for ebook in data["latest_books"] as! [[String : Any]]
            {
                let book = EBook(aid: ebook["aid"].toString(),
                                 author_id: ebook["author_id"].toString(),
                                 author_name: ebook["author_name"].toString(),
                                 book_bg_img: ebook["book_bg_img"].toString(),
                                 book_cover_img: ebook["book_cover_img"].toString(),
                                 book_file_type: ebook["book_file_type"].toString(),
                                 book_title: ebook["book_title"].toString(),
                                 book_views: ebook["book_views"].toString(),
                                 cat_id: ebook["cat_id"].toString(),
                                 category_name: ebook["category_name"].toString(),
                                 cid: ebook["cid"].toString(),
                                 id: ebook["id"].toString(),
                                 rate_avg: ebook["rate_avg"].toString(),
                                 total_rate: ebook["total_rate"].toString(),
                                 book_description: ebook["book_description"].toString(),
                                 book_file_url: String(),
                                 book_video_file_type: String(),
                                 book_video_file_url: String(),
                                 book_youtube_id: String())
                Model.LatestEBooks.append(book)
            }
        }
        if(data["popular_books"] is [[String : Any]])
        {
            for ebook in data["popular_books"] as! [[String : Any]]
            {
                let book = EBook(aid: ebook["aid"].toString(),
                                 author_id: ebook["author_id"].toString(),
                                 author_name: ebook["author_name"].toString(),
                                 book_bg_img: ebook["book_bg_img"].toString(),
                                 book_cover_img: ebook["book_cover_img"].toString(),
                                 book_file_type: ebook["book_file_type"].toString(),
                                 book_title: ebook["book_title"].toString(),
                                 book_views: ebook["book_views"].toString(),
                                 cat_id: ebook["cat_id"].toString(),
                                 category_name: ebook["category_name"].toString(),
                                 cid: ebook["cid"].toString(),
                                 id: ebook["id"].toString(),
                                 rate_avg: ebook["rate_avg"].toString(),
                                 total_rate: ebook["total_rate"].toString(),
                                 book_description: ebook["book_description"].toString(),
                                 book_file_url: String(),
                                 book_video_file_type: String(),
                                 book_video_file_url: String(),
                                 book_youtube_id: String())
                Model.PopularEBooks.append(book)
            }
        }
        tableViewHome.reloadData()
    }
}



class EBookCell: UITableViewCell
{
    @IBOutlet weak var imgEBook: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    
    func initData(indexPath: IndexPath, type: BooksType)
    {
        if(type == .featured)
        {
            set(data: Model.FeaturedEBooks[indexPath.row])
        }
        else if(type == .latest)
        {
            set(data: Model.LatestEBooks[indexPath.row])
        }
        else
        {
            set(data: Model.PopularEBooks[indexPath.row])
        }
    }
    
    func set(data: EBook)
    {
        imgEBook.setImage(url: "http://ootlo.com/backend/images/" + data.book_bg_img, completion: ())
        lblTitle.text = data.book_title
        lblDesc.text = data.book_views + " " + "Views"
        lblRating.text = UIViewController().getRateWith(value: data.rate_avg.toInt()) + " " + data.total_rate
    }
    
}


