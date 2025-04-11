import Foundation

final class AppState: ObservableObject {
    @Published var status: StatusModel = .loading
    @Published var characters: [GOTResponse] = []
    
    private var useCase: CharacterUseCaseProtocol
    
    init(useCase: CharacterUseCaseProtocol = CharacterUseCase()) {
        self.useCase = useCase
        loadCharacters()
    }
    
    func loadCharacters() {
        
        useCase.getCharacters { [weak self] result in
            DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
                switch result {
                case .success(let characters):
                    DispatchQueue.main.async {
                        self?.characters = characters
                        self?.status = .loaded
                        print(characters)
                    }
                case .failure(let error):
                    self?.status = .error
                    print(error.localizedDescription)
                }
            }
        }
    }
        
}
