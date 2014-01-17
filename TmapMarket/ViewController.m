//
//  ViewController.m
//  TmapMarket
//
//  Created by SDT-1 on 2014. 1. 17..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "TMapView.h"

#define APP_KEY @"693b0d6b-de1f-3499-8283-ace081027e4f"
#define TOOLBAR_HEIGHT 80
@interface ViewController ()<TMapViewDelegate>

@property (strong, nonatomic) TMapView *mapView;
@end

@implementation ViewController

- (void)onClick:(TMapPoint *)TMP {
    NSLog(@"Tapped Point: %@", TMP);
}

- (void)onLongClick:(TMapPoint *)TMP {
    NSLog(@"Long clicked : %@", TMP);
}

- (void)onCalloutRightbuttonClick:(TMapMarkerItem *)markerItem {
    NSLog(@"Marker Id : %@", [markerItem getID]);
    if ([@"T-ACADEMY" isEqualToString:[markerItem getID]]) {
        DetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
        detailVC.urlStr = @"http://www.naver.com";
        
        //모달로 표시
        [self presentViewController:detailVC animated:YES completion:nil];
    }
}

- (void)onCustomObjectClick:(TMapObject *)obj {
    if ([obj isKindOfClass:[TMapMarkerItem class]]) {
        TMapMarkerItem *marker = (TMapMarkerItem *)obj;
        NSLog(@"Marker Clicked.. %@", [marker getID]);
    }
}

- (IBAction)addOverlay:(id)sender {
    CLLocationCoordinate2D coord[5] = {
        CLLocationCoordinate2DMake(37.460143, 126.914062),
        CLLocationCoordinate2DMake(37.469136, 126.981869),
        CLLocationCoordinate2DMake(37.437930, 126.989937),
        CLLocationCoordinate2DMake(37.413255, 126.959038),
        CLLocationCoordinate2DMake(37.426752, 126.913548)
    };
    
    TMapPolygon *polygon = [[TMapPolygon alloc] init];
    [polygon setLineColor:[UIColor redColor]];
    [polygon setPolygonAlpha:0];
    [polygon setLineWidth:8.0];
    
    for (int i = 0; i < 5; i++) {
        [polygon addPolygonPoint:[TMapPoint mapPointWithCoordinate:coord[i]]];
    }
    
    [self.mapView addTMapPolygonID:@"관악산" Polygon:polygon];
}

//마커 추가
- (IBAction)addMarker:(id)sender {
    NSString *itemID = @"T-ACADEMY";
    
    TMapPoint *point = [[TMapPoint alloc] initWithLon:126.96 Lat:37.466];
    TMapMarkerItem *marker = [[TMapMarkerItem alloc] initWithTMapPoint:point];
    [marker setIcon:[UIImage imageNamed:@"image1.png"]];
    
    //콜 아웃 설정
    [marker setCanShowCallout:YES];
    [marker setCalloutTitle:@"T-ACADEMY"];
    [marker setCalloutRightButtonImage:[UIImage imageNamed:@"right_arrow.png"]];
    
    [self.mapView addTMapMarkerItemID:itemID Marker:marker];
    
}

- (IBAction)moveToSeoul:(id)sender {
    TMapPoint *centerPoint = [[TMapPoint alloc] initWithLon:126.96 Lat:37.466];
    [self.mapView setCenterPoint:centerPoint];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect rect = CGRectMake(0, TOOLBAR_HEIGHT, self.view.frame.size.width, self.view.frame.size.height - TOOLBAR_HEIGHT);
    self.mapView = [[TMapView alloc] initWithFrame:rect];
    [self.mapView setSKPMapApiKey:APP_KEY];
    self.mapView.zoomLevel = 12.0;
    
    //델리게이트 지정
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
