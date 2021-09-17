//
//  ViewController.swift
//  RxSwiftApiServiceProject
//
//  Created by zapbuild on 17/09/21.
//

import UIKit
import RxSwift
import RxCocoa


class ViewController: UIViewController {

    @IBOutlet weak var newsTableView: UITableView!
    private var viewModel = ViewModel()
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        bindTableView()
    }
    
    private func bindTableView() {

         viewModel.articles.bind(to: newsTableView.rx.items(cellIdentifier: "cellID", cellType: NewsTableViewCell.self)) { (row,item,cell) in
            cell.setup(article: item)
         }.disposed(by: disposeBag)
        
        viewModel.loadData()
     }

}

