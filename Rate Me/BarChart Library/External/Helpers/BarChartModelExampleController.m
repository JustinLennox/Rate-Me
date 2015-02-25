//
//  BarChartModelExampleController.m
//  BarChart
//
//  Created by Everett Michaud on 9/5/13.
//
//

#import "BarChartModelExampleController.h"
#import "BarChartView.h"
#import "BarChartModel.h"

@interface BarChartModelExampleController ()
@property (weak, nonatomic) IBOutlet BarChartView *iboBarChart2;
@property (nonatomic,strong) BarChartModel *chart2Model;
@end

@implementation BarChartModelExampleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *title = @"Wins by Team";
    if (self.navigationController) {
        self.navigationItem.title = title;
    } else {
        self.title = title;
    }
    
    // Initialize chart model
    self.chart2Model = [[BarChartModel alloc] initWithBarChart:self.iboBarChart2];
    
    // This example demonstrates adding a bar item manually then uses the completion block to push a new view controller, which in this example, does a furthur breakdown of the values.
    [self addItemWithViewControllerDrillDownExample];
    
    
    // Demonstrates a an easy way to add an item with very basic customization
    [self.chart2Model addItem:@16 title:@"Lions" barColor:[UIColor greenColor] labelColor:nil showPopupTip:YES onSelection:nil];
    
    
    // Demonstrates using the onSelection block to present an alert view
    [self addItemWithAlertPopupExample];
    
    // Demonstrates using the onSelection block to present an action sheet
    [self addItemWithActionSheetExample];
    
    // This example shows how to generate your chart once your model is fully configured.  Use the preconfiguration block to set available properties on the bar chart.
    [self presentChartUsingPreConfigurationBlockExample];
}

- (void)addItemWithViewControllerDrillDownExample {
    __weak typeof(self) blockSelf = self;
    NSArray *item1Values = @[@17,@23,@20,@14];
    
    [self.chart2Model addItem:[item1Values valueForKeyPath:@"@sum.self"] title:@"Bears" showPopupTip:NO onSelection:^(BarView *barView, NSString *title, NSNumber *value, int index) {
        UIViewController *controller = [[UIViewController alloc]init];
        controller.title = title;
        BarChartView *chart = [[BarChartView alloc] initWithFrame:CGRectMake(10, 100, 300, 300)];
        BarChartModel *model = [[BarChartModel alloc] initWithBarChart:chart];
        
        for (NSNumber *num in item1Values) {
            [model addItem:num title:[num stringValue] showPopupTip:YES];
        }
        
        [model updateChartWithPreConfiguration:^(BarChartView *barChart) {
            [barChart  setupBarViewShape:BarShapeRounded];
            [barChart setupBarViewStyle:BarStyleFlat];
            [barChart  setupBarViewShadow:BarShadowHeavy];
            barChart.barCornerRadius = 4.0f;
            [barChart setupBarViewAnimation:BarAnimationFade];
        }];
        
        [controller.view addSubview:chart];
        
        [blockSelf.navigationController pushViewController:controller animated:YES];
        controller.view.backgroundColor = [UIColor whiteColor];
        return;
    }];
}

- (void)addItemWithAlertPopupExample {
    [self.chart2Model addItem:@91 title:@"Bears" barColor:[UIColor brownColor] labelColor:[UIColor blueColor] showPopupTip:NO onSelection:^(BarView *barView, NSString *title, NSNumber *value, int index) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Bar Item Selected" message:[NSString stringWithFormat:@"You selected: %@ \nValue: %@",title,value] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alertView show];
    }];
    
}

- (void)addItemWithActionSheetExample {
    __weak typeof(self) blockSelf = self;
    
    [self.chart2Model addItem:@93 title:@"Oh My!"  barColor:nil labelColor:nil showPopupTip:NO onSelection:^(BarView *barView, NSString *title, NSNumber *value, int index) {
        NSLog(@"block selection - bar:%@ value:%@ index:%d", title, value, index);
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:[NSString stringWithFormat:@"You selected: %@ \nValue: %@", title, value] delegate:nil cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Destroy" otherButtonTitles:@"Other", nil];
        [actionSheet showFromTabBar:blockSelf.tabBarController.tabBar];
    }];
    
}

- (void)presentChartUsingPreConfigurationBlockExample {
    [self.chart2Model updateChartWithPreConfiguration:^(BarChartView *barChart) {
        // Set the Shape of the Bars (Rounded or Squared) - Rounded is default
        [barChart  setupBarViewShape:BarShapeRounded];
        
        // Set the Style of the Bars (Glossy, Matte, or Flat) - Glossy is default
        [barChart setupBarViewStyle:BarStyleFlat];
        
        // Set the Drop Shadow of the Bars (Light, Heavy, or None) - Light is default
        [barChart  setupBarViewShadow:BarShadowHeavy];
        
        // Set the corner radius
        barChart.barCornerRadius = 4.0f;
        
        // [barChart setBackgroundColor:[UIColor clearColor]];
        // Set the Initial Animation of the Bars (Rise, Float, Fade, or None) - Rise is default
        [barChart setupBarViewAnimation:BarAnimationRise];
    }];
}

@end
