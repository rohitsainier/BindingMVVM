//
//  ViewController.swift
//  BindingMVVM
//
//  Created by Rohit Saini on 01/03/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var viewModel: HomeViewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    private func configUI(){
        tableView.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
        //Binding Data
        viewModel.didReceivedUsers()
        viewModel.users.bind { [weak self](_) in
            guard let `self` = self else{return}
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    

    @IBAction func clickAddBtn(_ sender: UIBarButtonItem) {
        let user = User(id: 11, name: "ABC", username: "ABC", email: "ABC", address: nil, phone: "ABC", website: "ABC", company: nil, isFavourite: true)
        viewModel.addNewUser(user: user)
    }
    

}

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as? HomeCell else {return UITableViewCell()}
        cell.configureCell(user: viewModel.users.value[indexPath.row])
        return cell
    }
    
}
