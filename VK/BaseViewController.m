//
//  BaseViewController.m
//  VK
//
//  Created by Mikhail Prysiazhniy on 12.09.16.
//  Copyright © 2016 Mikhail Prysiazhniy. All rights reserved.
//

#import "BaseViewController.h"
#import "SWRevealViewController.h"
#import "Masonry/Masonry.h"
#import "AppDelegate.h"

#import "Router.h"
@interface BaseViewController () <UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *vKwebView;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self initStartup];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)initStartup{
//    Router *router = [Router new];
    
     AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
//    SWRevealViewController *revealController = [self revealViewController];
    UIWindow *window = appDelegate.window;
    SWRevealViewController *revealController = (id)window.rootViewController;
    
    
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Show"
                                                                         style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
//    
//    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
//                                                                         style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    
    
    _vKwebView = [[UIWebView alloc] init];
    self.vKwebView.delegate = self;
    
    [self.view addSubview:self.vKwebView];
    [self.vKwebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    
    NSString *str = @"https://oauth.vk.com/authorize?client_id=5607233&scope=offline&redirect_uri=oauth.vk.com/blank.html&display=touch&response_type=token";
    
    NSURL *authURL = [[NSURL alloc] initWithString:str];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:authURL];
    [self.vKwebView loadRequest:urlRequest];
}


//-(void) webViewDidFinishLoad:(UIWebView *)webView {
//    NSLog(@"invoke");
//    //создадим хеш-таблицу для хранения данных
//    NSMutableDictionary* user = [[NSMutableDictionary alloc] init];
//    //смотрим на адрес открытой станицы
//    NSString *currentURL = webView.request.URL.absoluteString;
//    NSRange textRange =[[currentURL lowercaseString] rangeOfString:[@"access_token" lowercaseString]];
//    //смотрим, содержится ли в адресе информация о токене
//    if(textRange.location != NSNotFound){
//        //Ура, содержится, вытягиваем ее
//        NSArray* data = [currentURL componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"=&"]];
//        [user setObject:[data objectAtIndex:1] forKey:@"access_token"];
//        [user setObject:[data objectAtIndex:3] forKey:@"expires_in"];
//        [user setObject:[data objectAtIndex:5] forKey:@"user_id"];
////        [self closeWebView];
//        //передаем всю информацию специально обученному классу
////        [[VkontakteDelegate sharedInstance] loginWithParams:user];
//
//    }
//    else {
//        //Ну иначе сообщаем об ошибке...
//        textRange =[[currentURL lowercaseString] rangeOfString:[@"access_denied" lowercaseString]];
//        if (textRange.location != NSNotFound) {
//            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Ooops! something gonna wrong..." message:@"Check your internet connection and try again!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
//            [alert show];
////            [self closeWebView];
//        }
//    }
//}


-(void)webViewDidFinishLoad:(UIWebView *)webView {
    // Если есть токен сохраняем его
    if ([webView.request.URL.absoluteString rangeOfString:@"access_token"].location != NSNotFound) {
        NSString *absoluteString = webView.request.URL.absoluteString;
        NSArray* data = [absoluteString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"=&"]];
        NSString *accessToken = [data objectAtIndex:1];
        NSString *userExpAt = [data objectAtIndex:3];
        NSString *user_id = [data objectAtIndex:5];
        
        if(user_id){
            [[NSUserDefaults standardUserDefaults] setObject:user_id forKey:@"VKAccessUserId"];
        }
        
        if(accessToken){
            [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:@"VKAccessToken"];
            // Сохраняем дату получения токена. Параметр expires_in=86400 в ответе ВКонтакта, говорит сколько будет действовать токен.
            // В данном случае, это для примера, мы можем проверять позднее истек ли токен или нет
            [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"VKAccessTokenDate"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        

        [self.vKwebView removeFromSuperview];
        self.vKwebView = nil;
        
    } else if ([webView.request.URL.absoluteString rangeOfString:@"error"].location != NSNotFound) {
        NSLog(@"Error: %@", webView.request.URL.absoluteString);
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


@end
