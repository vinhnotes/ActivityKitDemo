//
//  LiveScoreRepository.swift
//  ActivityKit-Demo
//
//  Created by vinhvd on 27/09/2022.
//

import Foundation

class LiveScoreRepository: ObservableObject {
    
    @Published var matches = [Match]()
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    let service: APIServiceProtocol
    
    init(service: APIServiceProtocol = APIService()) {
        self.service = service
        fetchAllLiveScore()
    }
    
    func fetchAllLiveScore() {
        
        isLoading = true
        errorMessage = nil
        
        let url = URL(string: "https://apiv3.apifootball.com/?action=get_events&from=2022-10-3&to=2022-10-9&league_id=152&APIkey=17f1a94b19bbe658adc674d36e4216ae2b06f3a2ef4300bb2bc3fdd202f40c0c")
        service.getLiveScore(url: url) { [unowned self] result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print(error)
                case .success(let matches):
                    print("--- sucess with \(matches.count)")
                    self.matches = matches
                }
            }
        }
        
    }
    
    
    //MARK: preview helpers
    
    static func errorState() -> LiveScoreRepository {
        let repository = LiveScoreRepository()
        repository.errorMessage = APIError.noNetwork.localizedDescription
        return repository
    }
    
    static func successState() -> LiveScoreRepository {
        let repository = LiveScoreRepository()
        repository.matches = [Match.example1(), Match.example2()]
        
        return repository
    }
}
