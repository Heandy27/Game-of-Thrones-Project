import Foundation

final class CharacterRepository: CharacterRepositoryProtocol {
    var network: CharacterNetworkProtocol
    
    init(network: CharacterNetworkProtocol = CharacterNetwork()) {
        self.network = network
    }
    
    func getCharacters(completion: @escaping (Result<[GOTResponse], ErrorApp>) -> Void) {
        network.getCharacters { result in
            switch result {
            case .success(let characters):
                completion(.success(characters))
            case .failure(_):
                completion(.failure(ErrorApp.noDataReceived))
            }
        }
    }
}
