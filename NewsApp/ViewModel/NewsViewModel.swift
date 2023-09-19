//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by PINAR KALKAN on 19.09.2023.
//

import Foundation

//MVVM'e göre oluşturduğun view kadar viewmodel'ın olması gerekir.
//ViewModel, Model ve View arasında köprü görevi görür.
//View içerisinde gösterilecek veriler burda çekip hazırlanır
//Bundan sonra view controllera gidip private olarak viewmodel oluştur.

struct NewsTableViewModel {
    
    let newsList : [News]
  
}

extension NewsTableViewModel {
    
    func numberOfRowsInSection () -> Int {
        return self.newsList.count
    }
    
    //dizi olarak aldığı haberlerden tekil bir haber objesi çekme
    func newsAtIndexPath (_ index: Int) -> NewsViewModel {
        let news = self.newsList[index]
        return NewsViewModel(news: news)
    }
}

//Verileri döndürme
struct NewsViewModel {
    
    let news : News
    
    var title : String {
        return self.news.title
    }
    
    var story : String {
        return self.news.story
    }
}
