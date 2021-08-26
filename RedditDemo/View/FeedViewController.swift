//
//  ViewController.swift
//  RedditDemo
//
//  Created by dhruva beti on 8/25/21.
//

import UIKit
import PaginatedTableView

class FeedViewController: UIViewController {
    
    @IBOutlet weak var tableView: PaginatedTableView!
    
    var feedVM = FeedViewModel()
   // let introLabel = UILabel()
    let redditImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadredditImageView()

        tableView.isHidden = true
        tableView.register(UINib(nibName: "FeedCell", bundle: nil), forCellReuseIdentifier: "feedCell")
        
        feedVM.getData(urlString: "https://www.reddit.com/.json") {
            DispatchQueue.main.async {
                self.redditImageView.isHidden = true
                self.tableView.isHidden = false
                self.tableView.paginatedDataSource = self
                self.tableView.paginatedDelegate = self
                self.tableView.reloadData()
            }
        }
        
    }
    
    func loadredditImageView(){
        redditImageView.frame.size = CGSize(width: 300, height: 150)
        redditImageView.frame.origin = CGPoint(x:view.center.x - redditImageView.frame.width/2 , y: view.center.y - redditImageView.frame.height/2)
        redditImageView.isHidden = false
        redditImageView.image = UIImage(named: "Reddit")
        view.addSubview(redditImageView)
    }
    
}

extension FeedViewController:PaginatedTableViewDataSource, PaginatedTableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedVM.childrenList?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedCell
        
        let index = indexPath.row
        cell.titLabel.text = feedVM.getTitle(atIndex: index)
        cell.scoreLabel.text = feedVM.getScore(atIndex: index)
        cell.commentsLabel.text = feedVM.getComments(atIndex: index)
        cell.prevImage.image = nil
        cell.prevImage.image = self.feedVM.getImage(atIndex: index, size: cell.prevImage.bounds.size)
        
        return cell
    }
    
    func loadMore(_ pageNumber: Int, _ pageSize: Int, onSuccess: ((Bool) -> Void)?, onError: ((Error) -> Void)?){
        
        
        feedVM.getNextData(urlString: "https://www.reddit.com/.json?after=") { nextChildrenList in
            
            let moreDataAvailable = !nextChildrenList.isEmpty
            onSuccess?(moreDataAvailable)
        }
        
    }
    
}


