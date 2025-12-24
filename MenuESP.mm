#import <UIKit/UIKit.h>

__attribute__((constructor))
static void init() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        UIWindow *win = nil;
        // Pega a janela principal sem usar o comando 'keyWindow'
        for (UIWindowScene* scene in [UIApplication sharedApplication].connectedScenes) {
            if (scene.activationState == UISceneActivationStateForegroundActive) {
                for (UIWindow *window in scene.windows) {
                    if (window.isKeyWindow) {
                        win = window;
                        break;
                    }
                }
            }
        }

        // Se não achar via Scene, tenta o fallback de segurança (janela 0)
        if (!win && [UIApplication sharedApplication].windows.count > 0) {
            win = [UIApplication sharedApplication].windows[0];
        }

        if (win) {
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, win.frame.size.width, 40)];
            lab.text = @"[ MENU ATIVO ]";
            lab.textColor = [UIColor whiteColor];
            lab.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.8];
            lab.textAlignment = NSTextAlignmentCenter;
            lab.font = [UIFont boldSystemFontOfSize:16];
            lab.layer.cornerRadius = 10;
            lab.clipsToBounds = YES;
            [win addSubview:lab];
        }
    });
}
