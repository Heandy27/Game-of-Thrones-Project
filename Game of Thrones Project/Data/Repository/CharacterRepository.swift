import Foundation

final class CharacterRepository: CharacterRepositoryProtocol {
    var network: CharacterNetworkProtocol
    
    init(network: CharacterNetworkProtocol = CharacterNetwork()) {
        self.network = network
    }
    
    func getCharacters(completion: @escaping (Result<[GOTResponse], ErrorApp>) -> Void) {
        network.getCharacters(completion: completion)
    }
}

final class CharacterRepositoryMock: CharacterRepositoryProtocol {
    
    var network: CharacterNetworkProtocol
 
    
    
    init(network: CharacterNetworkProtocol) {
        self.network = network
    }
    
    func getCharacters(completion: @escaping (Result<[GOTResponse], ErrorApp>) -> Void) {
        network.getCharacters(completion: completion)
    }
    
    
}
