////
////  CreateFollowUserService.swift
////  entrepreneurship-great-app
////
////  Created by Leonardo Viana on 25/09/20.
////
//
//import Foundation
//import UIKit
//import CloudKit
//
//enum CreateFollowUserServiceResult {
//    case success, failed
//}
//
//class CreateFollowUserService {
//    
//    var usersRepository: UsersRepository
//    
//    init() {
//        self.usersRepository = UsersRepository()
//    }
//    
//    public func execute(followerInfos: UserInfo, followedInfos: UserInfo, completionHandler: @escaping (CreateFollowUserServiceResult, UserInfo?, UserInfo?, Error?) -> ()) {
//        //salvar user record infos com novo seguidor
//        //
//        guard let followerInfosId = followerInfos.recordID else {
//            return
//        }
//        
//        guard let followedInfosId = followedInfos.recordID else {
//            return
//        }
//        
//        followerInfos.following?.append(CKRecord.Reference(recordID: followedInfosId, action: .none))
//        
//        followedInfos.followers?.append(CKRecord.Reference(recordID: followerInfosId, action: .none))
//        
//        usersRepository.saveUserInfo(userInfo: followerInfos) {
//            userInfos, error in
//            
//            guard let followerUserInfos = userInfos, error == nil else {
//                return
//            }
//            
//            self.usersRepository.saveUserInfo(userInfo: followedInfos) {
//                userInfos, error in
//                
//                guard let followedUserInfos = userInfos, error == nil else {
//                    return
//                }
//                
//                completionHandler(followerUserInfos, nil)
//            }
//        }
//    }
//}
