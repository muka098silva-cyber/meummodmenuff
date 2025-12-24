#import <UIKit/UIKit.h>

// Função que inicia o mod
__attribute__((constructor))
static void inicializarMod() {
    // Espera 5 segundos para o jogo abrir totalmente
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        
        // Cria um painel visual simples
        UIView *painel = [[UIView alloc] initWithFrame:CGRectMake(50, 100, 200, 60)];
        painel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        painel.layer.cornerRadius = 10;
        painel.layer.borderWidth = 2;
        painel.layer.borderColor = [UIColor greenColor].CGColor;
        
        UILabel *texto = [[UILabel alloc] initWithFrame:painel.bounds];
        texto.text = @"MOD ATIVO\nTOQUE COM 3 DEDOS";
        texto.textColor = [UIColor greenColor];
        texto.textAlignment = NSTextAlignmentCenter;
        texto.numberOfLines = 2;
        texto.font = [UIFont boldSystemFontOfSize:14];
        
        [painel addSubview:texto];
        [window addSubview:painel];
        
        // Proteção para não ser detectado facilmente
        unsetenv("DYLD_INSERT_LIBRARIES");
    });
}
