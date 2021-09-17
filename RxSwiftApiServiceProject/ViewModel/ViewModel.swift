//
//  ViewModel.swift
//  RxSwiftApiServiceProject
//
//  Created by zapbuild on 17/09/21.
//

import Foundation
import RxCocoa
import RxSwift


struct ViewModel {
    
    let error = PublishSubject<String>()
    
    let articles = PublishSubject<[Article]>()
    
    func loadData(){
        // Do any additional setup after loading the view.
        NetworkService().fetchGenericData(urlString: Constants.newApi) { (result: Result<News,Error>) in
            switch result{
            
            case .success(let news):
                print(news.articles)
                self.articles.onNext(news.articles)
            case .failure(let error):
                print(error.localizedDescription)
                self.error.onNext(error.localizedDescription)
            }
        }
    }
}
