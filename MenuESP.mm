#import <UIKit/UIKit.h>
#import <objc/runtime.h>

// --- INTERFACE DO MENU ---
@interface ModMenu : UIView
@property (nonatomic, strong) UIView *menuView;
@property (nonatomic, strong) UIButton *iconButton;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation ModMenu

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.userInteractionEnabled = YES;
        [self setupFloatingIcon];
        [self setupMainMenu];
    }
    return self;
}

// 1. ÍCONE FLUTUANTE
- (void)setupFloatingIcon {
    self.iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.iconButton.frame = CGRectMake(50, 150, 50, 50);
    self.iconButton.backgroundColor = [UIColor redColor]; // Cor do ícone
    self.iconButton.layer.cornerRadius = 25;
    [self.iconButton setTitle:@"M" forState:UIControlStateNormal];
    [self.iconButton addTarget:self action:@selector(toggleMenu) forControlEvents:UIControlEventTouchUpInside];
    
    // Gesto para arrastar o ícone
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.iconButton addGestureRecognizer:pan];
    
    [self addSubview:self.iconButton];
}

// 2. TELA DO MENU (BOTÕES)
- (void)setupMainMenu {
    self.menuView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 350)];
    self.menuView.center = self.center;
    self.menuView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.9];
    self.menuView.layer.cornerRadius = 15;
    self.menuView.hidden = YES;
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 280, 30)];
    title.text = @"SAMUEL MOD MENU";
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    [self.menuView addSubview:title];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, 280, 290)];
    [self.menuView addSubview:self.scrollView];
    
    // ADICIONANDO OS BOTÕES (SWITCHES)
    [self addOption:@"Ativar Todas ESP" tag:1 y:10];
    [self addOption:@"ESP Caixa" tag:2 y:50];
    [self addOption:@"ESP Esqueleto" tag:3 y:90];
    [self addOption:@"ESP Linha" tag:4 y:130];
    [self addOption:@"ESP Vida" tag:5 y:170];
    [self addOption:@"Anti-Ban / Bypass" tag:6 y:210];
    [self addOption:@"Stream Mode" tag:7 y:250];
    
    [self addSubview:self.menuView];
}

- (void)addOption:(NSString *)name tag:(int)tag y:(int)y {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, y, 150, 30)];
    label.text = name;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14];
    [self.scrollView addSubview:label];
    
    UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(210, y, 0, 0)];
    sw.tag = tag;
    [sw addTarget:self action:@selector(optionChanged:) forControlEvents:UIControlEventValueChanged];
    [self.scrollView addSubview:sw];
}

// --- LÓGICA DAS FUNÇÕES ---
- (void)optionChanged:(UISwitch *)sender {
    switch (sender.tag) {
        case 1: /* Ativar Todas ESP */ break;
        case 6: /* Bypass */ break;
        case 7: // STREAM MODE
            if (sender.isOn) {
                self.layer.sublayerTransform = CATransform3DMakeTranslation(0, 0, 10000); // Esconde da gravação
            } else {
                self.layer.sublayerTransform = CATransform3DIdentity;
            }
            break;
    }
}

// --- CONTROLES DE MOVIMENTO E EXIBIÇÃO ---
- (void)toggleMenu { self.menuView.hidden = !self.menuView.hidden; }

- (void)handlePan:(UIPanGestureRecognizer *)pan {
    CGPoint translation = [pan translationInView:self];
    pan.view.center = CGPointMake(pan.view.center.x + translation.x, pan.view.center.y + translation.y);
    [pan setTranslation:CGPointZero inView:self];
}
@end

// --- INICIALIZAÇÃO ---
__attribute__((constructor))
static void init() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIWindow *window = nil;
        for (UIWindowScene* scene in [UIApplication sharedApplication].connectedScenes) {
            if (scene.activationState == UISceneActivationStateForegroundActive) {
                window = scene.windows.firstObject;
                break;
            }
        }
        if (window) {
            ModMenu *menu = [[ModMenu alloc] initWithFrame:window.bounds];
            [window addSubview:menu];
        }
    });
}
