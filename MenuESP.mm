#import <UIKit/UIKit.h>

__attribute__((constructor))
static void init() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        UIWindow *win = nil;
        // Forma moderna de pegar a janela no iOS 13, 14, 15, 16, 17 e 18
        if (@available(iOS 13.0, *)) {
            for (UIWindowScene* scene in [UIApplication sharedApplication].connectedScenes) {
                if (scene.activationState == UISceneActivationStateForegroundActive) {
                    win = scene.windows.firstObject;
                    break;
                }
            }
        } else {
            win = [UIApplication sharedApplication].keyWindow;
        }

        if (win) {
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, win.frame.size.width, 30)];
            lab.text = @"MOD CARREGADO COM SUCESSO!";
            lab.textColor = [UIColor greenColor];
            lab.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
            lab.textAlignment = NSTextAlignmentCenter;
            lab.font = [UIFont boldSystemFontOfSize:14];
            [win addSubview:lab];
        }
    });
}
