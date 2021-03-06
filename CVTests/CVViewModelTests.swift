//
//  CVViewModelTests.swift
//  CVTests
//
//  Created by Krzysztof Kaczmarek on 18/01/2021.
//  Copyright © 2021 Kaczmarek. All rights reserved.
//

import XCTest
@testable import CV

class CVViewModelTests: XCTestCase {
    var viewModel: CV.ViewModel!

    func testShouldShowAlertWhenRequestFails() {
        let fakeRepository = FakeCVRepository()
        fakeRepository.shouldSucceed = false
        let fakeView = FakeCVView()
        viewModel = CV.ViewModel(repository: fakeRepository)
        viewModel.view = fakeView
        viewModel.sendAction(.didLoad)

        guard let state = fakeView.currentState else {
            XCTFail("State is nil!")
            return
        }
        XCTAssert(state.alert == CV.Alert.errorWithRetry(message: "Couldn't load CV, try again."))
    }
    
    func testShouldUpdateStateWithCVWhenRequestSucceeds() {
        let fakeRepository = FakeCVRepository()
        fakeRepository.shouldSucceed = true
        let fakeView = FakeCVView()
        viewModel = CV.ViewModel(repository: fakeRepository)
        viewModel.view = fakeView
        viewModel.sendAction(.didLoad)
        
        guard let state = fakeView.currentState else {
            XCTFail("State is nil!")
            return
        }
        XCTAssert(state.alert == CV.Alert.none)
        XCTAssertNotNil(state.model)
    }

}

class FakeCVView: CVViewProtocol {
    var currentState: CV.State?
    
    func update(with state: CV.State) {
        self.currentState = state
    }
    
    
}

class FakeCVRepository: CVRepositoryProtocol {
    var shouldSucceed: Bool = true
    
    func fetchCV(completion: (Result<CVModel>) -> Void) {
        if shouldSucceed {
            fetchCVWithSuccess(completion: completion)
        }
        else {
            fetchCVWithFailure(completion: completion)
        }
    }
    
    func fetchCVWithSuccess(completion: (Result<CVModel>) -> Void) {
        completion(.success(value: CVModel(header: Header(name: "Krzysztof Kaczmarek", phoneNumber: "+48 883 141 558", email: "kaczmarek.krzysztof.0@gmail.com"),
                                           profile: DescriptionItem(description: "Experienced iOS Developer who leverages latest technology and good practices to deliver high quality software. Thriving as leader, enjoying every minute of mentoring less experienced colleagues. Always eager to learn new things. Not a fan of being smartest person in the room."),
                                           experience: [TitleWithDescriptionItem(title: "LEAD IOS DEVELOPER, BRIGHT INVENTIONS, GDANSK — 06.2019 - NOW", description: "When I joined Bright Inventions, my main task was to clean and optimize current project for high scale. I introduced new architecture along with refactoring code base, increased test coverage and implemented processes to make sure my team follows the best practices to provide high quality code. I am responsible for maintaining close relationship with the clients, leading my team and mentoring colleagues. I had opportunity to represent company on Cocoaheads Tricity meetup."),
                                                        TitleWithDescriptionItem(title: "LEAD IOS DEVELOPER, SKYRISE, GDANSK — 06.2017 - 05.2019", description: "As lead iOS developer at Skyrise, I worked on several applications for company clients. Alongside app development, I was responsible for architecting applications, mentoring junior developers, managing my team and recruiting new developers."),
                                                        TitleWithDescriptionItem(title: "IOS DEVELOPER, SGROUPLES, REMOTELY — 12.2014 - 05.2017", description: "As a software developer at american startup Sgrouples, I was part of iOS team developing social media application for iPhones and iPads called MeWe. I was responsible for architecting and developing new application components, maintaining existing components and optimizing application for high users traffic.")],
                                           education: [DescriptionItem(description: "University of Technology, Gdansk — Computer Science with Physics, Engineer, 2012- 2016")],
                                           skills: [TitleWithDescriptionItem(title: "Languages", description: "Swift, Objective-C"),
                                                    TitleWithDescriptionItem(title: "Architectures", description: "MVVM, MVP, MVC, Modular Architecture"),
                                                    TitleWithDescriptionItem(title: "Frameworks", description: "iOS SDK, RxSwift, XCTest, Quick/Nimble, Realm, SnapKit, CoreData, PromiseKit"),
                                                    TitleWithDescriptionItem(title: "Tools", description: "Xcode, Git, Jira, CocoaPods, Carthage, Fastlane, SPM")])))
    }
    
    func fetchCVWithFailure(completion: (Result<CVModel>) -> Void) {
        completion(.failure(error: RequestError()))
    }
}
