


#import "SocialIntegrationVC.h"
#import "FaceBookModel.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
@import Firebase;
@import GoogleSignIn;
#define  NULL_CHECKER(X) [X isKindOfClass:[NSNull class]]?nil:X

@interface SocialIntegrationVC ()<GIDSignInUIDelegate ,GIDSignInDelegate>
{
    NSMutableArray *faceBookData;
    NSString *gmailName;
    NSString *gmailEmailId;
    NSString *gmailID;
    NSString *userIDStr;
    NSString *givenName;
    NSString *familyName;
}

@end

@implementation SocialIntegrationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    faceBookData =[NSMutableArray new];
    gmailName = [NSString new];
    gmailEmailId = [NSString new];
    gmailID = [NSString new];
    userIDStr = [NSString new];
    givenName = [NSString new];
    familyName = [NSString new];
    
}
- (IBAction)backButtonAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)loginThroughFaceBook:(id)sender {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    
    [login
     logInWithReadPermissions: @[@"public_profile",@"email",@"user_friends"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             
             if ([FBSDKAccessToken currentAccessToken]) {
                 
                 [self getFacebookDetail];
                 NSLog(@"Results=%@",result);
                 
             }
             NSLog(@"Logged in");
         }
     }];;
}


- (void)getFacebookDetail {
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setValue:@"id,name,email" forKey:@"fields"];
    
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                  id result, NSError *error) {
         
         NSLog(@"fetch user:%@ and email:%@ ",result,result[@"email,user_birthday"]);
         
         
         NSDictionary *dict = result;
         
         if (dict) {
             
             FaceBookModel *fModel = [[FaceBookModel alloc]init];
             fModel.faceBookID = NULL_CHECKER(dict[@"id"]);
             fModel.faceBookName = NULL_CHECKER(dict[@"name"]);
             fModel.faceBookEmailID = NULL_CHECKER(dict[@"email"]);
             
             [faceBookData addObject:fModel];
             
             // [self performSegueWithIdentifier:@"faceBookSague" sender:nil];
             
             
         }
         
         else
         {
             UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"there is some issue with facebook authentication" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil ];
             [alert show];
         }
         
         
     }];
}
- (IBAction)loginThroughGmail:(id)sender {
    
    //    GIDSignIn.sharedInstance().clientID = "1030612214396-2dcvs5u9r4a9mjosga93euua93rehv49.apps.googleusercontent.com"
    //
    // GIDSignIn.sharedInstance().clientID = "72551746081-ntvb0sfagqodek61mqor44k0ksc4ja2r.apps.googleusercontent.com"
    
    [GIDSignIn sharedInstance].clientID = @"621269543245-qbngg001b482f9uj817quj9qd3kaddi2.apps.googleusercontent.com";
    
    [GIDSignIn sharedInstance].uiDelegate = self;
    [GIDSignIn sharedInstance].delegate = self;
    
    [[GIDSignIn sharedInstance] signIn];
    
    
}


- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // ...
    if (error == nil) {
        gmailName = user.profile.name;
        gmailEmailId = user.profile.email;
        gmailID = user.authentication.idToken;
        userIDStr = user.userID;
        givenName = user.profile.givenName;
        familyName= user.profile.familyName;
        // ...
    } else {
        // ...
    }
}


@end

