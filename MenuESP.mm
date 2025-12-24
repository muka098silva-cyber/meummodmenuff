#import <UIKit/UIKit.h>

__attribute__((constructor))
static void init() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIWindow *win = [[UIApplication sharedApplication] keyWindow];
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, win.frame.size.width, 30)];
        lab.text = @"MOD CARREGADO!";
        lab.textColor = [UIColor greenColor];
        lab.backgroundColor = [UIColor blackColor];
        lab.textAlignment = NSTextAlignmentCenter;
        [win addSubview:lab];
    });
}
