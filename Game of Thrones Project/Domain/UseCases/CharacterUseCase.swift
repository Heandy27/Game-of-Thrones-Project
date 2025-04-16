import Foundation

final class CharacterUseCase: CharacterUseCaseProtocol {
    var repo:  CharacterRepositoryProtocol
    
    init(repo: CharacterRepositoryProtocol = CharacterRepository()) {
        self.repo = repo
    }
    
    func getCharacters(completion: @escaping (Result<[GOTResponse], ErrorApp>) -> Void) {
        repo.getCharacters(completion: completion)
    }
    
    
}
