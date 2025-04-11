import Foundation

final class CharacterUseCase: CharacterUseCaseProtocol {
    var repo:  CharacterRepositoryProtocol
    
    init(repo: CharacterRepositoryProtocol = CharacterRepository()) {
        self.repo = repo
    }
    
    func getCharacters(completion: @escaping (Result<[GOTResponse], ErrorApp>) -> Void) {
        repo.getCharacters { result in
            switch result {
                
            case .success(let characters):
                completion(.success(characters))
            case .failure(_):
                completion(.failure(ErrorApp.noDataReceived))
            }
        }
    }
    
    
}
