//
//  HomeViewModel.swift
//  MVVMExercise
//
//  Created by Rohit Saini on 28/02/21.
//

import UIKit

protocol HomeViewModelBindingProtocol{
    var users: Box<[User]> { get  set }
    var errMessage: Box<String?> {get set}
    func didReceivedUsers(session: URLSession)
    func didReceivedError(msg: String)
    func addNewUser(user: User)
}

class HomeViewModel:HomeViewModelBindingProtocol{
    var users: Box<[User]> = Box([])
    var errMessage: Box<String?> = Box(nil)
    
    //fetch users list
    func didReceivedUsers(session: URLSession = .shared){
        session.request(.users, using: Void()) { [weak self] (result) in
            guard let `self` = self else{return}
            switch result{
            case .success(let response):
                print(response)
                self.users.value = response
            case .failure(let err):
                print(err)
                self.didReceivedError(msg: err.localizedDescription)
            }
        }
    }
    
    func addNewUser(user: User) {
        self.users.value.append(user)
    }
    
    //Error
    func didReceivedError(msg: String) {
        errMessage.value = msg
    }
}

