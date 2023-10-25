//
//  File.swift
//  
//
//  Created by 이상헌 on 2023/10/23.
//

import Foundation

public struct MyError: Error, Equatable {
    public let title: String
    public let messaage: String
    
    init(error: Error) {
        guard let myError = error as? MyError else {
            self.title = "Default Error"
            self.messaage = "error"
            return
        }
        self.title = myError.title
        self.messaage = myError.messaage
    }
    
    init(title: String, messaage: String) {
        self.title = title
        self.messaage = messaage
    }
}

// MARK: - default error

extension MyError {
    public static let defaultError: Self = .init(title: "에러 발생", messaage: "제보 및 문의 부탁드립니다")
    public static let cancelCallError: Self = .init(title: "호출 취소 실패", messaage: "호출 취소에 실패했습니다.")
    public static let firebaseConfigureError: Self = .init(title: "configure firebase first", messaage: "firebase configure error")
    public static let noError: Self = .init(title: "noError", messaage: "noError")
    public static let networkNullError: Self = .init(title: "FAIL", messaage: "DATA IS NULL")
}
