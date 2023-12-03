//
//  BookmarkModelDataStreamTests.swift
//  
//
//  Created by 이상헌 on 12/3/23.
//

import XCTest

import RxSwift
import RxTest

import Entities
import Repository
import RepositoryTestSupports
import UsecaseTestSupports
import ProxyTestSupport
@testable import UsecaseImpl

final class BookmarkModelDataStreamImplTests: XCTestCase {

  var sut: BookmarkModelDataStreamImpl!
    
  override func setUp() {
    
    
    sut = BookmarkModelDataStreamImpl()
  }

}
