//
//  LiveScoreRepository.swift
//  ActivityKit-Demo
//
//  Created by vinhvd on 27/09/2022.
//

import Foundation

class LiveScoreViewModel: ObservableObject {
    
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
        
        let url = URL(string: "https://apiv3.apifootball.com/?action=get_events&from=2022-10-3&to=2022-10-9&league_id=152&APIkey=")
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
    
    static func errorState() -> LiveScoreViewModel {
        let repository = LiveScoreViewModel()
        repository.errorMessage = APIError.noNetwork.localizedDescription
        return repository
    }
    
    static func successState() -> LiveScoreViewModel {
        let repository = LiveScoreViewModel()
        repository.matches = [Match.example1(), Match.example2()]
        
        return repository
    }
}
