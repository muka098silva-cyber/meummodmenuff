#import <UIKit/UIKit.h>

// Isso evita erros de compilação em algumas versões do SDK
@interface UIWindow (Private)
- (void)makeKeyAndVisible;
@end

static void inicializarMenu() {
    // Cria um alerta simples na tela quando o jogo abrir
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"MOD MENU"
                                                                       message:@"Injetado com Sucesso!"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:ok];
        
        [keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    });
}

// Construtor que injeta o código no jogo
__attribute__((constructor))
static void custom_init() {
    inicializarMenu();
    // Limpa vestígios de injeção
    unsetenv("DYLD_INSERT_LIBRARIES");
}
