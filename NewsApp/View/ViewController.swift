//
//  ViewController.swift
//  NewsApp
//
//  Created by PINAR KALKAN on 19.09.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    private var newsTableViewModel : NewsTableViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        //tableView'da satırların otomatik olarak haber metninin uzunluğu kadar olması için:
        //Yani boyutları dinamik olacak
        //Sonra en altta heightforrow func çağır
        //Sonra storyboradda story labelın özelliklerine gidip lines: 0 yap.
        //Yine storyboradda story label seçiliyken, yeni constrait ekle -> height seç,size inspectorı aç ve eklediğin height cons için edit -> = yerine >= ve 32 olarak değiştir.
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        getData()
    }
    
    func getData () {
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/BTK-iOSDataSet/master/dataset.json")
        
        WebService().downloadNews(url: url!) { news in
            if let news = news {
                self.newsTableViewModel = NewsTableViewModel(newsList: news)
                
                
                
                //Reload işleminbi alttaki gibi dispatch içinde yapmazsan uygulama çöker.
                //Çünkü reload main threadde verilmeli.
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsTableViewModel == nil ? 0 : self.newsTableViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsCell
        let newsViewModel = self.newsTableViewModel.newsAtIndexPath(indexPath.row)
        cell.titleLabel.text = newsViewModel.title
        cell.storyLabel.text = newsViewModel.story
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

