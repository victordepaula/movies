//
//  ArcTouchTests.swift
//  ArcTouchTests
//
//  Created by Victor de Paula Fernandes Pereira on 23/08/2018.
//  Copyright © 2018 Victor de Paula Fernandes Pereira. All rights reserved.
//

import XCTest
import RxSwift
@testable import ArcTouch

class ArcTouchTests: XCTestCase {
    let viewModel = MoviesViewModel()
    let disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testListByGenre() {
        measure {
            viewModel.listGenreMovies()
                .observeOn(MainScheduler.instance).subscribe(onNext: { (service) in
                    for item in (self.viewModel.genreResponse?.genres)! {
                        self.viewModel.listMoviesByGenre(genreId: String(describing:item.id ?? 0
                        ), genreName: item.name ?? "")
                            .observeOn(MainScheduler.instance).subscribe(onNext: { (service) in
                            }, onError: { (error) in
                                
                            }, onCompleted: {
                            }, onDisposed: {
                                
                            }).disposed(by: self.disposeBag)
                    }
                }, onError: { (error) in
                    
                }, onCompleted: {
                }, onDisposed: {
                    
                }).disposed(by: disposeBag)
        }
    }
    
    func testMovieId() {
        measure {
            viewModel.getMovieById(moviesId: "353081")
                .observeOn(MainScheduler.instance).subscribe(onNext: { (service) in
                }, onError: { (error) in
                }, onCompleted: {
                }, onDisposed: {
                }).disposed(by: disposeBag)
        }
    }
    
    func testSearchMovie() {
        measure {
            viewModel.searchMovies(name: "the", language: "pt-Br", page: "1")
                .observeOn(MainScheduler.instance).subscribe(onNext: { (service) in
                }, onError: { (error) in
                }, onCompleted: {
                }, onDisposed: {
                }).disposed(by: disposeBag)
        }
    }
    
    
    func testViewModel() {
        measure {
            viewModel.listUpCommingMovies()
                .observeOn(MainScheduler.instance).subscribe(onNext: { (service) in
                }, onError: { (error) in
                }, onCompleted: {
                }, onDisposed: {
                }).disposed(by: disposeBag)
        }
    }
}
