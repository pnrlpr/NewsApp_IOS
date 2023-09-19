//
//  WebService.swift
//  NewsApp
//
//  Created by PINAR KALKAN on 19.09.2023.
//

import Foundation


class WebService {
    
    //Escaping Closure
    func downloadNews (url: URL, completion: @escaping ([News]?) -> ()) {
        //verileri internetten indirmek
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                //eğer hata mesajı yoksa
                //gelen JSON verisini bir news dizisine çevir
                //Model'i decodeable yaptığımız için JSONu decode edebiliriz
                let newsArray = try? JSONDecoder().decode([News].self, from: data)
                
                if let newsArray = newsArray {
                    completion(newsArray)
                }
            }
        }.resume() //Bütün bu taskı başlatmak için resume() yazmalısın
    }
    
}
